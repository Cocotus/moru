import 'package:freezed_annotation/freezed_annotation.dart';

part 'patch_rule.freezed.dart';
part 'patch_rule.g.dart';

/// A single search & replace rule of a patcher configuration.
///
/// This is the Flutter port of the `Patch` class from the original
/// MoRPatcher C# console tool, extended with a [description], a grouping
/// [category] and an [isActive] flag so the user can toggle individual
/// rules in the UI before applying them.
///
/// Every field has a default value (`@Default`) so that `fromJson` tolerates
/// hand-edited config files that omit a key.
@freezed
abstract class PatchRule with _$PatchRule {
  /// Creates a [PatchRule] instance.
  const factory PatchRule({
    /// Short human-readable title of the rule, shown on its switch tile.
    @Default('') String name,

    /// Optional longer explanation shown below the title.
    @Default('') String description,

    /// Group label used to cluster related rules in the UI.
    @Default('') String category,

    /// The literal text that must exist in the HTML file.
    @Default('') String searchText,

    /// The literal text that replaces every occurrence of [searchText].
    @Default('') String replaceText,

    /// Whether this rule is applied during a patch run.
    @Default(true) bool isActive,
  }) = _PatchRule;

  /// Creates a [PatchRule] instance from a JSON map.
  factory PatchRule.fromJson(Map<String, dynamic> json) =>
      _$PatchRuleFromJson(json);
}
