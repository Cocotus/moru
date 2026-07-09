import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_template_appwrite/l10n/app_localizations.dart';
import 'package:flutter_template_appwrite/models/patch_result.dart';
import 'package:flutter_template_appwrite/models/patch_rule.dart';
import 'package:flutter_template_appwrite/models/patcher_config.dart';
import 'package:flutter_template_appwrite/views/home/home_controller.dart';
import 'package:flutter_template_appwrite/views/home/home_state.dart';
import 'package:flutter_template_appwrite/widgets/app_snackbar.dart';
import 'package:flutter_template_appwrite/widgets/empty_state.dart';

// A category header plus the indexes (into `PatcherConfig.rules`) of the
// rules belonging to it — the view's grouping helper structure.
class _RuleGroup {
  const _RuleGroup({required this.category, required this.ruleIndexes});

  final String category;
  final List<int> ruleIndexes;
}

/// The MoRPatcher home view.
///
/// The whole page is driven by an imported `config_morpatcher.json`: its
/// rules are rendered as switch tiles grouped by category. Together with an
/// imported game HTML file the user can run the patch, download the
/// `*_patched.html` result and export the configuration as a backup.
class HomeView extends ConsumerWidget {
  /// Creates a [HomeView].
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final AsyncValue<HomeState> asyncState = ref.watch(homeControllerProvider);

    // Surface controller errors as a snackbar; the loaded data itself stays
    // visible because the controller keeps the previous state.
    ref.listen<AsyncValue<HomeState>>(
      homeControllerProvider,
      (AsyncValue<HomeState>? previous, AsyncValue<HomeState> next) {
        if (next.hasError && next.isLoading == false) {
          final String message;
          if (next.error is FormatException) {
            message = localizations.invalidConfigFile;
          } else {
            message = localizations.errorGeneric;
          }
          showErrorSnackbar(context, message);
        }
      },
    );

    // Riverpod 3 keeps the previous data available while loading / on error.
    final HomeState state = asyncState.value ?? const HomeState();
    final bool isBusy = asyncState.isLoading;
    final HomeController controller =
        ref.read(homeControllerProvider.notifier);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildHeader(context, localizations),
              const SizedBox(height: 24),
              _buildFilesCard(
                context: context,
                localizations: localizations,
                state: state,
                controller: controller,
                isBusy: isBusy,
              ),
              const SizedBox(height: 16),
              _buildActionsCard(
                context: context,
                localizations: localizations,
                state: state,
                controller: controller,
                isBusy: isBusy,
              ),
              const SizedBox(height: 24),
              if (!state.hasConfig)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 48),
                  child: Center(
                    child: EmptyState(
                      message: localizations.noConfigLoaded,
                      icon: Icons.rule_folder_outlined,
                    ),
                  ),
                )
              else
                ..._buildRuleGroupCards(
                  context: context,
                  localizations: localizations,
                  state: state,
                  controller: controller,
                  isBusy: isBusy,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations localizations) {
    return Row(
      children: <Widget>[
        Image.asset('assets/images/logo.png', height: 48),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                localizations.appTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 4),
              Text(
                localizations.homeIntro,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Card with the two file slots: the patcher configuration and the game
  // HTML file, each with its import button(s).
  Widget _buildFilesCard({
    required BuildContext context,
    required AppLocalizations localizations,
    required HomeState state,
    required HomeController controller,
    required bool isBusy,
  }) {
    final String configSubtitle;
    if (state.hasConfig) {
      configSubtitle = '${state.configFileName} · '
          '${localizations.configRulesSummary(state.activeRuleCount, state.config.rules.length)}';
    } else {
      configSubtitle = localizations.noConfigLoaded;
    }

    final String htmlSubtitle;
    if (state.hasHtml) {
      htmlSubtitle = state.htmlFileName;
    } else {
      htmlSubtitle = localizations.noHtmlLoaded;
    }

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: Icon(
              state.hasConfig ? Icons.rule : Icons.rule_folder_outlined,
              color: state.hasConfig
                  ? Theme.of(context).colorScheme.primary
                  : null,
            ),
            title: Text(localizations.patcherConfigTitle),
            subtitle: Text(configSubtitle),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Wrap(
              spacing: 12,
              runSpacing: 8,
              children: <Widget>[
                FilledButton.tonalIcon(
                  onPressed: isBusy ? null : controller.importConfig,
                  icon: const Icon(Icons.file_open_outlined),
                  label: Text(localizations.importConfig),
                ),
                OutlinedButton.icon(
                  onPressed: isBusy ? null : controller.loadDefaultConfig,
                  icon: const Icon(Icons.restore_page_outlined),
                  label: Text(localizations.loadDefaultConfig),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ListTile(
            leading: Icon(
              state.hasHtml ? Icons.description : Icons.description_outlined,
              color:
                  state.hasHtml ? Theme.of(context).colorScheme.primary : null,
            ),
            title: Text(localizations.htmlFileTitle),
            subtitle: Text(htmlSubtitle),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: FilledButton.tonalIcon(
              onPressed: isBusy ? null : controller.importHtmlFile,
              icon: const Icon(Icons.upload_file_outlined),
              label: Text(localizations.chooseHtmlFile),
            ),
          ),
        ],
      ),
    );
  }

  // Card with the main actions (patch / download / backup) and the summary
  // of the last patch run.
  Widget _buildActionsCard({
    required BuildContext context,
    required AppLocalizations localizations,
    required HomeState state,
    required HomeController controller,
    required bool isBusy,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Wrap(
              spacing: 12,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                FilledButton.icon(
                  onPressed: state.canPatch && !isBusy
                      ? controller.applyPatches
                      : null,
                  icon: const Icon(Icons.healing_outlined),
                  label: Text(localizations.patch),
                ),
                OutlinedButton.icon(
                  onPressed: state.hasPatchedOutput && !isBusy
                      ? controller.downloadPatchedFile
                      : null,
                  icon: const Icon(Icons.download_outlined),
                  label: Text(localizations.downloadPatched),
                ),
                OutlinedButton.icon(
                  onPressed: state.hasConfig && !isBusy
                      ? controller.backupConfig
                      : null,
                  icon: const Icon(Icons.save_outlined),
                  label: Text(localizations.backupConfig),
                ),
                if (isBusy)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
            ),
            if (state.results.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.task_alt,
                      size: 18,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      localizations.patchRunSummary(
                        state.appliedRuleCount,
                        state.results.length,
                      ),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // One card per category, each holding the switch tiles of its rules.
  List<Widget> _buildRuleGroupCards({
    required BuildContext context,
    required AppLocalizations localizations,
    required HomeState state,
    required HomeController controller,
    required bool isBusy,
  }) {
    final List<_RuleGroup> groups =
        _groupRulesByCategory(state.config, localizations);

    final List<Widget> cards = <Widget>[];
    for (final _RuleGroup group in groups) {
      int activeInGroup = 0;
      for (final int ruleIndex in group.ruleIndexes) {
        if (state.config.rules[ruleIndex].isActive) {
          activeInGroup++;
        }
      }

      cards.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            group.category,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Text(
                          '$activeInGroup/${group.ruleIndexes.length}',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ),
                  for (final int ruleIndex in group.ruleIndexes)
                    _buildRuleTile(
                      context: context,
                      localizations: localizations,
                      state: state,
                      controller: controller,
                      isBusy: isBusy,
                      ruleIndex: ruleIndex,
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return cards;
  }

  Widget _buildRuleTile({
    required BuildContext context,
    required AppLocalizations localizations,
    required HomeState state,
    required HomeController controller,
    required bool isBusy,
    required int ruleIndex,
  }) {
    final PatchRule rule = state.config.rules[ruleIndex];
    final PatchResult? result = state.results[ruleIndex];

    // After a patch run every tile shows its outcome, mirroring the
    // "Patch xyz OK!/ERROR!" console output of the original tool.
    Widget? resultIcon;
    if (result != null) {
      if (result.wasFound) {
        resultIcon = Tooltip(
          message: localizations.ruleReplacements(result.matchCount),
          child: Icon(
            Icons.check_circle_outline,
            color: Theme.of(context).colorScheme.primary,
          ),
        );
      } else {
        resultIcon = Tooltip(
          message: localizations.ruleNotFound,
          child: Icon(
            Icons.error_outline,
            color: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }

    return SwitchListTile(
      title: Text(rule.name),
      subtitle: rule.description.isEmpty ? null : Text(rule.description),
      secondary: resultIcon,
      value: rule.isActive,
      onChanged: isBusy
          ? null
          : (bool newValue) {
              controller.toggleRule(ruleIndex: ruleIndex, isActive: newValue);
            },
    );
  }

  // Groups the rule indexes by category, keeping the order in which the
  // categories first appear in the config file.
  List<_RuleGroup> _groupRulesByCategory(
    PatcherConfig config,
    AppLocalizations localizations,
  ) {
    final Map<String, List<int>> indexesByCategory = <String, List<int>>{};
    for (int ruleIndex = 0; ruleIndex < config.rules.length; ruleIndex++) {
      final PatchRule rule = config.rules[ruleIndex];
      final String category =
          rule.category.isEmpty ? localizations.uncategorized : rule.category;
      final List<int> indexes =
          indexesByCategory.putIfAbsent(category, () => <int>[]);
      indexes.add(ruleIndex);
    }

    final List<_RuleGroup> groups = <_RuleGroup>[];
    indexesByCategory.forEach((String category, List<int> ruleIndexes) {
      groups.add(_RuleGroup(category: category, ruleIndexes: ruleIndexes));
    });
    return groups;
  }
}
