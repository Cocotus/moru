// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patch_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PatchRule _$PatchRuleFromJson(Map<String, dynamic> json) => _PatchRule(
  name: json['name'] as String? ?? '',
  description: json['description'] as String? ?? '',
  category: json['category'] as String? ?? '',
  searchText: json['searchText'] as String? ?? '',
  replaceText: json['replaceText'] as String? ?? '',
  isActive: json['isActive'] as bool? ?? true,
);

Map<String, dynamic> _$PatchRuleToJson(_PatchRule instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'searchText': instance.searchText,
      'replaceText': instance.replaceText,
      'isActive': instance.isActive,
    };
