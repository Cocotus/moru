import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_template_appwrite/l10n/app_localizations.dart';
import 'package:flutter_template_appwrite/services/file_transfer_service.dart';
import 'package:flutter_template_appwrite/views/home/home_controller.dart';
import 'package:flutter_template_appwrite/views/home/home_view.dart';
import 'package:flutter_template_appwrite/widgets/empty_state.dart';

import '../fakes/fake_services.dart';

/// Widget tests for [HomeView], the MoRPatcher main screen.
void main() {
  late FakeFileTransferService fakeFileTransfer;
  late ProviderContainer container;

  setUp(() {
    fakeFileTransfer = FakeFileTransferService();
    container = ProviderContainer(
      overrides: [
        fileTransferServiceProvider.overrideWithValue(fakeFileTransfer),
      ],
    );
    addTearDown(container.dispose);
  });

  Future<void> pumpHomeView(WidgetTester tester) async {
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: HomeView()),
        ),
      ),
    );
  }

  testWidgets('shows the empty state and a disabled Patch button initially',
      (WidgetTester tester) async {
    await pumpHomeView(tester);

    expect(find.byType(EmptyState), findsOneWidget);

    final FilledButton patchButton = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Patch'),
    );
    expect(patchButton.onPressed, isNull);
  });

  testWidgets(
      'loading the bundled default config renders grouped switch tiles',
      (WidgetTester tester) async {
    await pumpHomeView(tester);

    // Load the real bundled asset — this also verifies that the shipped
    // config_morpatcher.json parses correctly. `runAsync` is required
    // because rootBundle does real asynchronous I/O.
    await tester.runAsync(() async {
      final HomeController controller =
          container.read(homeControllerProvider.notifier);
      await controller.loadDefaultConfig();
    });
    await tester.pumpAndSettle();

    expect(find.byType(EmptyState), findsNothing);
    expect(find.byType(SwitchListTile), findsWidgets);
    // A well-known category header from the extracted C# patch list.
    expect(find.text('Assembly Work'), findsOneWidget);
  });
}
