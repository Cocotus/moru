// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patch_rule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PatchRule {

/// Short human-readable title of the rule, shown on its switch tile.
 String get name;/// Optional longer explanation shown below the title.
 String get description;/// Group label used to cluster related rules in the UI.
 String get category;/// The literal text that must exist in the HTML file.
 String get searchText;/// The literal text that replaces every occurrence of [searchText].
 String get replaceText;/// Whether this rule is applied during a patch run.
 bool get isActive;
/// Create a copy of PatchRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PatchRuleCopyWith<PatchRule> get copyWith => _$PatchRuleCopyWithImpl<PatchRule>(this as PatchRule, _$identity);

  /// Serializes this PatchRule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatchRule&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.searchText, searchText) || other.searchText == searchText)&&(identical(other.replaceText, replaceText) || other.replaceText == replaceText)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,category,searchText,replaceText,isActive);

@override
String toString() {
  return 'PatchRule(name: $name, description: $description, category: $category, searchText: $searchText, replaceText: $replaceText, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $PatchRuleCopyWith<$Res>  {
  factory $PatchRuleCopyWith(PatchRule value, $Res Function(PatchRule) _then) = _$PatchRuleCopyWithImpl;
@useResult
$Res call({
 String name, String description, String category, String searchText, String replaceText, bool isActive
});




}
/// @nodoc
class _$PatchRuleCopyWithImpl<$Res>
    implements $PatchRuleCopyWith<$Res> {
  _$PatchRuleCopyWithImpl(this._self, this._then);

  final PatchRule _self;
  final $Res Function(PatchRule) _then;

/// Create a copy of PatchRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = null,Object? category = null,Object? searchText = null,Object? replaceText = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,searchText: null == searchText ? _self.searchText : searchText // ignore: cast_nullable_to_non_nullable
as String,replaceText: null == replaceText ? _self.replaceText : replaceText // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PatchRule].
extension PatchRulePatterns on PatchRule {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PatchRule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PatchRule() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PatchRule value)  $default,){
final _that = this;
switch (_that) {
case _PatchRule():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PatchRule value)?  $default,){
final _that = this;
switch (_that) {
case _PatchRule() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String description,  String category,  String searchText,  String replaceText,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PatchRule() when $default != null:
return $default(_that.name,_that.description,_that.category,_that.searchText,_that.replaceText,_that.isActive);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String description,  String category,  String searchText,  String replaceText,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _PatchRule():
return $default(_that.name,_that.description,_that.category,_that.searchText,_that.replaceText,_that.isActive);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String description,  String category,  String searchText,  String replaceText,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _PatchRule() when $default != null:
return $default(_that.name,_that.description,_that.category,_that.searchText,_that.replaceText,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PatchRule implements PatchRule {
  const _PatchRule({this.name = '', this.description = '', this.category = '', this.searchText = '', this.replaceText = '', this.isActive = true});
  factory _PatchRule.fromJson(Map<String, dynamic> json) => _$PatchRuleFromJson(json);

/// Short human-readable title of the rule, shown on its switch tile.
@override@JsonKey() final  String name;
/// Optional longer explanation shown below the title.
@override@JsonKey() final  String description;
/// Group label used to cluster related rules in the UI.
@override@JsonKey() final  String category;
/// The literal text that must exist in the HTML file.
@override@JsonKey() final  String searchText;
/// The literal text that replaces every occurrence of [searchText].
@override@JsonKey() final  String replaceText;
/// Whether this rule is applied during a patch run.
@override@JsonKey() final  bool isActive;

/// Create a copy of PatchRule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PatchRuleCopyWith<_PatchRule> get copyWith => __$PatchRuleCopyWithImpl<_PatchRule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PatchRuleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PatchRule&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.searchText, searchText) || other.searchText == searchText)&&(identical(other.replaceText, replaceText) || other.replaceText == replaceText)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,category,searchText,replaceText,isActive);

@override
String toString() {
  return 'PatchRule(name: $name, description: $description, category: $category, searchText: $searchText, replaceText: $replaceText, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$PatchRuleCopyWith<$Res> implements $PatchRuleCopyWith<$Res> {
  factory _$PatchRuleCopyWith(_PatchRule value, $Res Function(_PatchRule) _then) = __$PatchRuleCopyWithImpl;
@override @useResult
$Res call({
 String name, String description, String category, String searchText, String replaceText, bool isActive
});




}
/// @nodoc
class __$PatchRuleCopyWithImpl<$Res>
    implements _$PatchRuleCopyWith<$Res> {
  __$PatchRuleCopyWithImpl(this._self, this._then);

  final _PatchRule _self;
  final $Res Function(_PatchRule) _then;

/// Create a copy of PatchRule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = null,Object? category = null,Object? searchText = null,Object? replaceText = null,Object? isActive = null,}) {
  return _then(_PatchRule(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,searchText: null == searchText ? _self.searchText : searchText // ignore: cast_nullable_to_non_nullable
as String,replaceText: null == replaceText ? _self.replaceText : replaceText // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
