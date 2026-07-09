import 'package:freezed_annotation/freezed_annotation.dart';

part 'patch_result.freezed.dart';
part 'patch_result.g.dart';

/// The outcome of applying one [ruleName] during a patch run.
///
/// Mirrors the per-patch "OK (n changes)" / "ERROR" console output of the
/// original MoRPatcher tool: [matchCount] is the number of occurrences that
/// were replaced, and [wasFound] tells whether the search text existed in
/// the HTML file at all.
@freezed
abstract class PatchResult with _$PatchResult {
  /// Creates a [PatchResult] instance.
  const factory PatchResult({
    /// The [name] of the rule this result belongs to.
    @Default('') String ruleName,

    /// How many occurrences of the search text were replaced.
    @Default(0) int matchCount,

    /// Whether the search text was found in the HTML file.
    @Default(false) bool wasFound,
  }) = _PatchResult;

  /// Creates a [PatchResult] instance from a JSON map.
  factory PatchResult.fromJson(Map<String, dynamic> json) =>
      _$PatchResultFromJson(json);
}
