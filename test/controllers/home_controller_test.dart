import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_template_appwrite/models/patcher_config.dart';
import 'package:flutter_template_appwrite/services/file_transfer_service.dart';
import 'package:flutter_template_appwrite/services/patcher_service.dart';
import 'package:flutter_template_appwrite/views/home/home_controller.dart';
import 'package:flutter_template_appwrite/views/home/home_state.dart';

import '../fakes/fake_services.dart';

/// Controller tests for [HomeController].
///
/// The file dialogs are replaced with [FakeFileTransferService], so the
/// tests can feed in config/HTML "files" and inspect what would have been
/// saved — no real file system or dialogs involved.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FakeFileTransferService fakeFileTransfer;

  const String configJson = '''
  {
    "name": "Test config",
    "rules": [
      {
        "name": "Tweak A",
        "category": "Combat",
        "searchText": "old-a",
        "replaceText": "new-a"
      },
      {
        "name": "Tweak B",
        "category": "Economy",
        "searchText": "not-in-file",
        "replaceText": "whatever"
      },
      {
        "name": "Tweak C (off)",
        "category": "Combat",
        "searchText": "old-c",
        "replaceText": "new-c",
        "isActive": false
      }
    ]
  }
  ''';

  ProviderContainer createContainer() {
    final ProviderContainer container = ProviderContainer(
      overrides: [
        fileTransferServiceProvider.overrideWithValue(fakeFileTransfer),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  setUp(() {
    fakeFileTransfer = FakeFileTransferService();
  });

  /// Loads [configJson] and a small HTML file into the controller.
  Future<HomeController> loadConfigAndHtml(ProviderContainer container) async {
    final HomeController controller =
        container.read(homeControllerProvider.notifier);

    fakeFileTransfer.filesToPick.add(
      const PickedTextFile(name: 'config_morpatcher.json', content: configJson),
    );
    await controller.importConfig();

    fakeFileTransfer.filesToPick.add(
      const PickedTextFile(
        name: 'start_game.html',
        content: '<html>old-a old-a old-c</html>',
      ),
    );
    await controller.importHtmlFile();

    return controller;
  }

  test('importConfig loads the rules from the picked JSON file', () async {
    final ProviderContainer container = createContainer();
    final HomeController controller =
        container.read(homeControllerProvider.notifier);

    fakeFileTransfer.filesToPick.add(
      const PickedTextFile(name: 'my_config.json', content: configJson),
    );
    await controller.importConfig();

    final HomeState state = container.read(homeControllerProvider).value!;
    expect(state.hasConfig, isTrue);
    expect(state.configFileName, 'my_config.json');
    expect(state.config.rules, hasLength(3));
    expect(state.activeRuleCount, 2);
  });

  test('importConfig with invalid JSON ends in AsyncError (FormatException)',
      () async {
    final ProviderContainer container = createContainer();
    final HomeController controller =
        container.read(homeControllerProvider.notifier);

    fakeFileTransfer.filesToPick.add(
      const PickedTextFile(name: 'broken.json', content: 'not json at all'),
    );
    await controller.importConfig();

    final AsyncValue<HomeState> state =
        container.read(homeControllerProvider);
    expect(state.hasError, isTrue);
    expect(state.error, isA<FormatException>());
  });

  test('canceling the file dialog keeps the previous state', () async {
    final ProviderContainer container = createContainer();
    final HomeController controller =
        container.read(homeControllerProvider.notifier);

    // No file queued -> the fake returns null like a canceled dialog.
    await controller.importConfig();

    final AsyncValue<HomeState> state =
        container.read(homeControllerProvider);
    expect(state.hasError, isFalse);
    expect(state.value!.hasConfig, isFalse);
  });

  test('applyPatches replaces text and reports per-rule results', () async {
    final ProviderContainer container = createContainer();
    final HomeController controller = await loadConfigAndHtml(container);

    await controller.applyPatches();

    final HomeState state = container.read(homeControllerProvider).value!;
    expect(state.hasPatchedOutput, isTrue);
    expect(state.patchedContent, '<html>new-a new-a old-c</html>');
    expect(state.patchedFileName, 'start_game_patched.html');

    // Rule 0 matched twice, rule 1 not found, rule 2 was inactive.
    expect(state.results, hasLength(2));
    expect(state.results[0]!.wasFound, isTrue);
    expect(state.results[0]!.matchCount, 2);
    expect(state.results[1]!.wasFound, isFalse);
    expect(state.results.containsKey(2), isFalse);
    expect(state.appliedRuleCount, 1);
  });

  test('toggleRule flips a rule and discards previous patch output',
      () async {
    final ProviderContainer container = createContainer();
    final HomeController controller = await loadConfigAndHtml(container);
    await controller.applyPatches();

    controller.toggleRule(ruleIndex: 2, isActive: true);

    final HomeState state = container.read(homeControllerProvider).value!;
    expect(state.config.rules[2].isActive, isTrue);
    // Output no longer matches the chosen rule set, so it was cleared.
    expect(state.hasPatchedOutput, isFalse);
    expect(state.results, isEmpty);
  });

  test('downloadPatchedFile saves the patched HTML under the _patched name',
      () async {
    final ProviderContainer container = createContainer();
    final HomeController controller = await loadConfigAndHtml(container);
    await controller.applyPatches();

    await controller.downloadPatchedFile();

    expect(fakeFileTransfer.savedFiles, hasLength(1));
    final SavedTextFile saved = fakeFileTransfer.savedFiles.first;
    expect(saved.fileName, 'start_game_patched.html');
    expect(saved.content, '<html>new-a new-a old-c</html>');
  });

  test('backupConfig saves the config including current isActive states',
      () async {
    final ProviderContainer container = createContainer();
    final HomeController controller = await loadConfigAndHtml(container);

    // Switch one rule off before the backup.
    controller.toggleRule(ruleIndex: 0, isActive: false);
    await controller.backupConfig();

    expect(fakeFileTransfer.savedFiles, hasLength(1));
    final SavedTextFile saved = fakeFileTransfer.savedFiles.first;
    expect(saved.fileName, 'config_morpatcher.json');

    // The backup must be importable again and carry the toggled state.
    const PatcherService patcher = PatcherService();
    final PatcherConfig restored = patcher.parseConfig(saved.content);
    expect(restored.rules, hasLength(3));
    expect(restored.rules[0].isActive, isFalse);
    expect(restored.rules[1].isActive, isTrue);
  });
}
