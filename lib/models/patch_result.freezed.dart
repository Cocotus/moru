// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patch_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PatchResult {

/// The [name] of the rule this result belongs to.
 String get ruleName;/// How many occurrences of the search text were replaced.
 int get matchCount;/// Whether the search text was found in the HTML file.
 bool get wasFound;
/// Create a copy of PatchResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PatchResultCopyWith<PatchResult> get copyWith => _$PatchResultCopyWithImpl<PatchResult>(this as PatchResult, _$identity);

  /// Serializes this PatchResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatchResult&&(identical(other.ruleName, ruleName) || other.ruleName == ruleName)&&(identical(other.matchCount, matchCount) || other.matchCount == matchCount)&&(identical(other.wasFound, wasFound) || other.wasFound == wasFound));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ruleName,matchCount,wasFound);

@override
String toString() {
  return 'PatchResult(ruleName: $ruleName, matchCount: $matchCount, wasFound: $wasFound)';
}


}

/// @nodoc
abstract mixin class $PatchResultCopyWith<$Res>  {
  factory $PatchResultCopyWith(PatchResult value, $Res Function(PatchResult) _then) = _$PatchResultCopyWithImpl;
@useResult
$Res call({
 String ruleName, int matchCount, bool wasFound
});




}
/// @nodoc
class _$PatchResultCopyWithImpl<$Res>
    implements $PatchResultCopyWith<$Res> {
  _$PatchResultCopyWithImpl(this._self, this._then);

  final PatchResult _self;
  final $Res Function(PatchResult) _then;

/// Create a copy of PatchResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ruleName = null,Object? matchCount = null,Object? wasFound = null,}) {
  return _then(_self.copyWith(
ruleName: null == ruleName ? _self.ruleName : ruleName // ignore: cast_nullable_to_non_nullable
as String,matchCount: null == matchCount ? _self.matchCount : matchCount // ignore: cast_nullable_to_non_nullable
as int,wasFound: null == wasFound ? _self.wasFound : wasFound // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PatchResult].
extension PatchResultPatterns on PatchResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PatchResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PatchResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PatchResult value)  $default,){
final _that = this;
switch (_that) {
case _PatchResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PatchResult value)?  $default,){
final _that = this;
switch (_that) {
case _PatchResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ruleName,  int matchCount,  bool wasFound)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PatchResult() when $default != null:
return $default(_that.ruleName,_that.matchCount,_that.wasFound);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ruleName,  int matchCount,  bool wasFound)  $default,) {final _that = this;
switch (_that) {
case _PatchResult():
return $default(_that.ruleName,_that.matchCount,_that.wasFound);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ruleName,  int matchCount,  bool wasFound)?  $default,) {final _that = this;
switch (_that) {
case _PatchResult() when $default != null:
return $default(_that.ruleName,_that.matchCount,_that.wasFound);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PatchResult implements PatchResult {
  const _PatchResult({this.ruleName = '', this.matchCount = 0, this.wasFound = false});
  factory _PatchResult.fromJson(Map<String, dynamic> json) => _$PatchResultFromJson(json);

/// The [name] of the rule this result belongs to.
@override@JsonKey() final  String ruleName;
/// How many occurrences of the search text were replaced.
@override@JsonKey() final  int matchCount;
/// Whether the search text was found in the HTML file.
@override@JsonKey() final  bool wasFound;

/// Create a copy of PatchResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PatchResultCopyWith<_PatchResult> get copyWith => __$PatchResultCopyWithImpl<_PatchResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PatchResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PatchResult&&(identical(other.ruleName, ruleName) || other.ruleName == ruleName)&&(identical(other.matchCount, matchCount) || other.matchCount == matchCount)&&(identical(other.wasFound, wasFound) || other.wasFound == wasFound));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ruleName,matchCount,wasFound);

@override
String toString() {
  return 'PatchResult(ruleName: $ruleName, matchCount: $matchCount, wasFound: $wasFound)';
}


}

/// @nodoc
abstract mixin class _$PatchResultCopyWith<$Res> implements $PatchResultCopyWith<$Res> {
  factory _$PatchResultCopyWith(_PatchResult value, $Res Function(_PatchResult) _then) = __$PatchResultCopyWithImpl;
@override @useResult
$Res call({
 String ruleName, int matchCount, bool wasFound
});




}
/// @nodoc
class __$PatchResultCopyWithImpl<$Res>
    implements _$PatchResultCopyWith<$Res> {
  __$PatchResultCopyWithImpl(this._self, this._then);

  final _PatchResult _self;
  final $Res Function(_PatchResult) _then;

/// Create a copy of PatchResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ruleName = null,Object? matchCount = null,Object? wasFound = null,}) {
  return _then(_PatchResult(
ruleName: null == ruleName ? _self.ruleName : ruleName // ignore: cast_nullable_to_non_nullable
as String,matchCount: null == matchCount ? _self.matchCount : matchCount // ignore: cast_nullable_to_non_nullable
as int,wasFound: null == wasFound ? _self.wasFound : wasFound // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
