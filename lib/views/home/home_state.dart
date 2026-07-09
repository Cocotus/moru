import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_template_appwrite/models/patch_result.dart';
import 'package:flutter_template_appwrite/models/patch_rule.dart';
import 'package:flutter_template_appwrite/models/patcher_config.dart';

part 'home_state.freezed.dart';

/// The complete state of the MoRPatcher home view.
///
/// Held by `HomeController` (keepAlive) so an imported configuration and
/// HTML file survive switching between sidebar tabs. "Not loaded" is
/// modeled as empty strings/collections instead of `null`, because Freezed's
/// `copyWith` cannot reset a field back to `null`.
@freezed
abstract class HomeState with _$HomeState {
  // Private constructor so the convenience getters below can exist.
  const HomeState._();

  /// Creates a [HomeState] instance.
  const factory HomeState({
    /// The currently loaded patcher configuration (empty when none).
    @Default(PatcherConfig()) PatcherConfig config,

    /// File name the configuration was imported from, e.g.
    /// `config_morpatcher.json` (empty when none is loaded).
    @Default('') String configFileName,

    /// File name of the imported game HTML file (empty when none).
    @Default('') String htmlFileName,

    /// Raw content of the imported game HTML file (empty when none).
    @Default('') String htmlContent,

    /// Patched HTML produced by the last patch run (empty before a run).
    @Default('') String patchedContent,

    /// Suggested download name for the patched file, e.g.
    /// `start_game_patched.html`.
    @Default('') String patchedFileName,

    /// Result of the last patch run, keyed by the rule's index in
    /// [PatcherConfig.rules]. Only active rules get an entry.
    @Default(<int, PatchResult>{}) Map<int, PatchResult> results,
  }) = _HomeState;

  /// Whether a configuration with at least one rule is loaded.
  bool get hasConfig => config.rules.isNotEmpty;

  /// Whether a game HTML file is loaded.
  bool get hasHtml => htmlContent.isNotEmpty;

  /// Whether the last patch run produced downloadable output.
  bool get hasPatchedOutput => patchedContent.isNotEmpty;

  /// Whether the "Patch" action is currently possible.
  bool get canPatch => hasConfig && hasHtml;

  /// How many rules are currently switched on.
  int get activeRuleCount {
    int count = 0;
    for (final PatchRule rule in config.rules) {
      if (rule.isActive) {
        count++;
      }
    }
    return count;
  }

  /// How many rules of the last run actually found their search text.
  int get appliedRuleCount {
    int count = 0;
    for (final PatchResult result in results.values) {
      if (result.wasFound) {
        count++;
      }
    }
    return count;
  }
}
