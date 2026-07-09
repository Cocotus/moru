import 'dart:async';

import 'package:flutter/foundation.dart' show compute;
import 'package:flutter/services.dart' show rootBundle;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutter_template_appwrite/models/patch_result.dart';
import 'package:flutter_template_appwrite/models/patch_rule.dart';
import 'package:flutter_template_appwrite/models/patcher_config.dart';
import 'package:flutter_template_appwrite/services/file_transfer_service.dart';
import 'package:flutter_template_appwrite/services/logger_service.dart';
import 'package:flutter_template_appwrite/services/patcher_service.dart';
import 'package:flutter_template_appwrite/views/home/home_state.dart';

part 'home_controller.g.dart';

/// Asset path of the bundled default configuration (extracted from the
/// original MoRPatcher C# console tool).
const String defaultConfigAssetPath = 'assets/config/config_morpatcher.json';

// Argument bundle for the background patch run — `compute` only accepts a
// single argument.
class _PatchJob {
  const _PatchJob({
    required this.service,
    required this.htmlContent,
    required this.config,
  });

  final PatcherService service;
  final String htmlContent;
  final PatcherConfig config;
}

// Top-level function so `compute` can run it on a background isolate
// (on web, `compute` simply runs it on the main thread).
PatchRunResult _runPatchJob(_PatchJob job) {
  return job.service.applyPatches(
    htmlContent: job.htmlContent,
    config: job.config,
  );
}

/// Controller for the MoRPatcher home view.
///
/// Owns the imported configuration, the imported game HTML file and the
/// result of the last patch run. `keepAlive` so the (potentially large)
/// loaded files survive tab switches. Progress and errors are exposed as
/// `AsyncValue<HomeState>`; the view surfaces errors via `ref.listen`.
@Riverpod(keepAlive: true)
class HomeController extends _$HomeController {
  @override
  FutureOr<HomeState> build() {
    return const HomeState();
  }

  // The last known state, also while loading or after an error (Riverpod 3
  // keeps the previous data available via `value`).
  HomeState get _current => state.value ?? const HomeState();

  /// Lets the user pick a `config_morpatcher.json` and loads it.
  ///
  /// A previous patch run is discarded because its results no longer match
  /// the new rule set.
  Future<void> importConfig() async {
    final LoggerService logger = ref.read(loggerServiceProvider);

    // Riverpod 3 automatically merges the previous data into loading/error
    // states, so the loaded files stay visible during every transition.
    state = const AsyncValue<HomeState>.loading();
    try {
      final FileTransferService fileTransfer =
          ref.read(fileTransferServiceProvider);
      final PickedTextFile? pickedFile = await fileTransfer.pickTextFile(
        allowedExtensions: <String>['json'],
      );
      if (pickedFile == null) {
        // User canceled the dialog — restore the previous idle state.
        state = AsyncValue<HomeState>.data(_current);
        return;
      }

      final PatcherService patcher = ref.read(patcherServiceProvider);
      final PatcherConfig config = patcher.parseConfig(pickedFile.content);

      logger.info(
        'Patcher config imported: ${pickedFile.name} '
        '(${config.rules.length} rules)',
      );
      state = AsyncValue<HomeState>.data(
        _current.copyWith(
          config: config,
          configFileName: pickedFile.name,
          patchedContent: '',
          patchedFileName: '',
          results: const <int, PatchResult>{},
        ),
      );
    } catch (error, stackTrace) {
      logger.handle(error, stackTrace, 'Importing patcher config failed');
      state = AsyncValue<HomeState>.error(error, stackTrace);
    }
  }

  /// Loads the bundled default configuration from the app assets.
  Future<void> loadDefaultConfig() async {
    final LoggerService logger = ref.read(loggerServiceProvider);

    state = const AsyncValue<HomeState>.loading();
    try {
      final String jsonString =
          await rootBundle.loadString(defaultConfigAssetPath);
      final PatcherService patcher = ref.read(patcherServiceProvider);
      final PatcherConfig config = patcher.parseConfig(jsonString);

      logger.info(
        'Bundled default patcher config loaded '
        '(${config.rules.length} rules)',
      );
      state = AsyncValue<HomeState>.data(
        _current.copyWith(
          config: config,
          configFileName: 'config_morpatcher.json',
          patchedContent: '',
          patchedFileName: '',
          results: const <int, PatchResult>{},
        ),
      );
    } catch (error, stackTrace) {
      logger.handle(error, stackTrace, 'Loading default config failed');
      state = AsyncValue<HomeState>.error(error, stackTrace);
    }
  }

  /// Lets the user pick the game HTML file (e.g. `start_game.html`).
  Future<void> importHtmlFile() async {
    final LoggerService logger = ref.read(loggerServiceProvider);

    state = const AsyncValue<HomeState>.loading();
    try {
      final FileTransferService fileTransfer =
          ref.read(fileTransferServiceProvider);
      final PickedTextFile? pickedFile = await fileTransfer.pickTextFile(
        allowedExtensions: <String>['html'],
      );
      if (pickedFile == null) {
        state = AsyncValue<HomeState>.data(_current);
        return;
      }

      logger.info(
        'Game HTML imported: ${pickedFile.name} '
        '(${pickedFile.content.length} characters)',
      );
      state = AsyncValue<HomeState>.data(
        _current.copyWith(
          htmlFileName: pickedFile.name,
          htmlContent: pickedFile.content,
          patchedContent: '',
          patchedFileName: '',
          results: const <int, PatchResult>{},
        ),
      );
    } catch (error, stackTrace) {
      logger.handle(error, stackTrace, 'Importing game HTML failed');
      state = AsyncValue<HomeState>.error(error, stackTrace);
    }
  }

  /// Switches the rule at [ruleIndex] on or off.
  ///
  /// Any previous patch output is discarded because it no longer matches
  /// the chosen rule set.
  void toggleRule({required int ruleIndex, required bool isActive}) {
    final HomeState current = _current;
    if (ruleIndex < 0 || ruleIndex >= current.config.rules.length) {
      return;
    }

    final List<PatchRule> updatedRules =
        List<PatchRule>.of(current.config.rules);
    updatedRules[ruleIndex] =
        updatedRules[ruleIndex].copyWith(isActive: isActive);

    state = AsyncValue<HomeState>.data(
      current.copyWith(
        config: current.config.copyWith(rules: updatedRules),
        patchedContent: '',
        patchedFileName: '',
        results: const <int, PatchResult>{},
      ),
    );
  }

  /// Applies all active rules to the imported HTML file.
  Future<void> applyPatches() async {
    final LoggerService logger = ref.read(loggerServiceProvider);
    final HomeState current = _current;
    if (!current.canPatch) {
      return;
    }

    state = const AsyncValue<HomeState>.loading();
    try {
      final PatcherService patcher = ref.read(patcherServiceProvider);

      // The game file can be tens of megabytes; on desktop this runs on a
      // background isolate so the UI stays responsive.
      final PatchRunResult runResult = await compute(
        _runPatchJob,
        _PatchJob(
          service: patcher,
          htmlContent: current.htmlContent,
          config: current.config,
        ),
      );

      // Re-key the run results by rule index so the view can show the
      // outcome on the matching switch tile (rule names may repeat).
      final Map<int, PatchResult> resultsByRuleIndex = <int, PatchResult>{};
      int resultIndex = 0;
      for (int ruleIndex = 0;
          ruleIndex < current.config.rules.length;
          ruleIndex++) {
        if (current.config.rules[ruleIndex].isActive) {
          resultsByRuleIndex[ruleIndex] = runResult.results[resultIndex];
          resultIndex++;
        }
      }

      logger.info(
        'Patch run finished: ${runResult.appliedCount} of '
        '${runResult.results.length} active rules applied',
      );
      state = AsyncValue<HomeState>.data(
        current.copyWith(
          patchedContent: runResult.patchedContent,
          patchedFileName: _patchedFileNameFor(current.htmlFileName),
          results: resultsByRuleIndex,
        ),
      );
    } catch (error, stackTrace) {
      logger.handle(error, stackTrace, 'Patch run failed');
      state = AsyncValue<HomeState>.error(error, stackTrace);
    }
  }

  /// Saves/downloads the patched HTML produced by the last run.
  Future<void> downloadPatchedFile() async {
    final LoggerService logger = ref.read(loggerServiceProvider);
    final HomeState current = _current;
    if (!current.hasPatchedOutput) {
      return;
    }

    state = const AsyncValue<HomeState>.loading();
    try {
      final FileTransferService fileTransfer =
          ref.read(fileTransferServiceProvider);
      final bool saved = await fileTransfer.saveTextFile(
        fileName: current.patchedFileName,
        content: current.patchedContent,
      );
      if (saved) {
        logger.info('Patched HTML saved as ${current.patchedFileName}');
      }
      state = AsyncValue<HomeState>.data(current);
    } catch (error, stackTrace) {
      logger.handle(error, stackTrace, 'Saving patched HTML failed');
      state = AsyncValue<HomeState>.error(error, stackTrace);
    }
  }

  /// Saves/downloads the current configuration (including the current
  /// on/off states) as a JSON backup that can be imported again later.
  Future<void> backupConfig() async {
    final LoggerService logger = ref.read(loggerServiceProvider);
    final HomeState current = _current;
    if (!current.hasConfig) {
      return;
    }

    state = const AsyncValue<HomeState>.loading();
    try {
      final PatcherService patcher = ref.read(patcherServiceProvider);
      final String jsonString = patcher.encodeConfig(current.config);

      final String fileName = current.configFileName.isNotEmpty
          ? current.configFileName
          : 'config_morpatcher.json';

      final FileTransferService fileTransfer =
          ref.read(fileTransferServiceProvider);
      final bool saved = await fileTransfer.saveTextFile(
        fileName: fileName,
        content: jsonString,
      );
      if (saved) {
        logger.info('Patcher config backup saved as $fileName');
      }
      state = AsyncValue<HomeState>.data(current);
    } catch (error, stackTrace) {
      logger.handle(error, stackTrace, 'Saving config backup failed');
      state = AsyncValue<HomeState>.error(error, stackTrace);
    }
  }

  // start_game.html -> start_game_patched.html (like the original tool).
  String _patchedFileNameFor(String htmlFileName) {
    if (htmlFileName.isEmpty) {
      return 'patched.html';
    }
    final int dotIndex = htmlFileName.lastIndexOf('.');
    if (dotIndex <= 0) {
      return '${htmlFileName}_patched.html';
    }
    final String baseName = htmlFileName.substring(0, dotIndex);
    return '${baseName}_patched.html';
  }
}
