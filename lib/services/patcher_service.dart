import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutter_template_appwrite/models/patch_result.dart';
import 'package:flutter_template_appwrite/models/patch_rule.dart';
import 'package:flutter_template_appwrite/models/patcher_config.dart';

part 'patcher_service.g.dart';

/// The result of one complete patch run over an HTML file.
///
/// Not persisted anywhere, therefore a plain immutable class instead of a
/// Freezed model: it only travels from [PatcherService.applyPatches] to the
/// home view state.
class PatchRunResult {
  /// Creates a [PatchRunResult].
  const PatchRunResult({
    required this.patchedContent,
    required this.results,
  });

  /// The HTML content after all active rules were applied.
  final String patchedContent;

  /// One entry per active rule, in the order the rules were applied.
  final List<PatchResult> results;

  /// How many active rules found (and replaced) their search text.
  int get appliedCount {
    int count = 0;
    for (final PatchResult result in results) {
      if (result.wasFound) {
        count++;
      }
    }
    return count;
  }
}

/// Pure string-patching logic, ported from the original MoRPatcher C# tool.
///
/// Stateless on purpose: parsing/encoding `config_morpatcher.json` and
/// applying literal search & replace rules to an HTML string. All file and
/// UI concerns live elsewhere (`FileTransferService`, `HomeController`).
class PatcherService {
  /// Creates a [PatcherService].
  const PatcherService();

  /// Parses [jsonString] into a [PatcherConfig].
  ///
  /// Throws a [FormatException] when the text is not valid JSON or does not
  /// have the expected object shape.
  PatcherConfig parseConfig(String jsonString) {
    final Object? decoded = jsonDecode(jsonString);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException(
        'The config file must contain a JSON object.',
      );
    }
    return PatcherConfig.fromJson(decoded);
  }

  /// Encodes [config] as pretty-printed JSON, e.g. for the backup download.
  String encodeConfig(PatcherConfig config) {
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(config.toJson());
  }

  /// Applies every active rule of [config] to [htmlContent].
  ///
  /// Behaves like the original C# patcher: each rule is a *literal* (not
  /// regex) replacement of every occurrence, and the rule's search/replace
  /// texts are normalized from Windows (`\r\n`) to Unix (`\n`) line endings
  /// before matching, because the game's `start_game.html` uses `\n`.
  /// Inactive rules are skipped entirely and get no [PatchResult].
  PatchRunResult applyPatches({
    required String htmlContent,
    required PatcherConfig config,
  }) {
    String patchedContent = htmlContent;
    final List<PatchResult> results = <PatchResult>[];

    for (final PatchRule rule in config.rules) {
      if (!rule.isActive) {
        continue;
      }

      final String searchText = _normalizeLineEndings(rule.searchText);
      final String replaceText = _normalizeLineEndings(rule.replaceText);

      if (searchText.isEmpty) {
        // An empty search text would match "everywhere"; report it as a
        // failed rule instead of corrupting the file.
        results.add(PatchResult(ruleName: rule.name));
        continue;
      }

      final int matchCount = countMatches(patchedContent, searchText);
      if (matchCount > 0) {
        patchedContent = patchedContent.replaceAll(searchText, replaceText);
      }

      results.add(
        PatchResult(
          ruleName: rule.name,
          matchCount: matchCount,
          wasFound: matchCount > 0,
        ),
      );
    }

    return PatchRunResult(patchedContent: patchedContent, results: results);
  }

  /// Counts the non-overlapping occurrences of [searchText] in [source].
  ///
  /// Non-overlapping (unlike the original C# `CountMatches` extension, which
  /// could count overlapping hits) so the count always equals the number of
  /// replacements `replaceAll` performs.
  int countMatches(String source, String searchText) {
    if (source.isEmpty || searchText.isEmpty) {
      return 0;
    }

    int count = 0;
    int startIndex = source.indexOf(searchText);
    while (startIndex != -1) {
      count++;
      startIndex = source.indexOf(searchText, startIndex + searchText.length);
    }
    return count;
  }

  // The rule texts may carry Windows line endings (they did in the C#
  // sources); the game file itself uses plain `\n`.
  String _normalizeLineEndings(String text) {
    return text.replaceAll('\r\n', '\n');
  }
}

/// Provides the app-wide [PatcherService] instance.
@Riverpod(keepAlive: true)
PatcherService patcherService(Ref ref) {
  return const PatcherService();
}
