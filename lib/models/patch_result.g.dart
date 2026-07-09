// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patch_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PatchResult _$PatchResultFromJson(Map<String, dynamic> json) => _PatchResult(
  ruleName: json['ruleName'] as String? ?? '',
  matchCount: (json['matchCount'] as num?)?.toInt() ?? 0,
  wasFound: json['wasFound'] as bool? ?? false,
);

Map<String, dynamic> _$PatchResultToJson(_PatchResult instance) =>
    <String, dynamic>{
      'ruleName': instance.ruleName,
      'matchCount': instance.matchCount,
      'wasFound': instance.wasFound,
    };
