// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patcher_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PatcherConfig _$PatcherConfigFromJson(Map<String, dynamic> json) =>
    _PatcherConfig(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      version: (json['version'] as num?)?.toInt() ?? 1,
      rules:
          (json['rules'] as List<dynamic>?)
              ?.map((e) => PatchRule.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PatchRule>[],
    );

Map<String, dynamic> _$PatcherConfigToJson(_PatcherConfig instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'version': instance.version,
      'rules': instance.rules,
    };
