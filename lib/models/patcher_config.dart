import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_template_appwrite/models/patch_rule.dart';

part 'patcher_config.freezed.dart';
part 'patcher_config.g.dart';

/// A complete patcher configuration (`config_morpatcher.json`).
///
/// The file is imported by the user on the home view, drives which switch
/// tiles are shown there, and can be exported again (including the current
/// [PatchRule.isActive] states) as a backup — the app deliberately works
/// without any database.
@freezed
abstract class PatcherConfig with _$PatcherConfig {
  /// Creates a [PatcherConfig] instance.
  const factory PatcherConfig({
    /// Display name of this configuration.
    @Default('') String name,

    /// Optional free-text description of what the configuration targets.
    @Default('') String description,

    /// Schema/config version, for future migrations of the file format.
    @Default(1) int version,

    /// The ordered list of search & replace rules.
    @Default(<PatchRule>[]) List<PatchRule> rules,
  }) = _PatcherConfig;

  /// Creates a [PatcherConfig] instance from a JSON map.
  factory PatcherConfig.fromJson(Map<String, dynamic> json) =>
      _$PatcherConfigFromJson(json);
}
