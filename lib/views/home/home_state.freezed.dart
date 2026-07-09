// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeState {

/// The currently loaded patcher configuration (empty when none).
 PatcherConfig get config;/// File name the configuration was imported from, e.g.
/// `config_morpatcher.json` (empty when none is loaded).
 String get configFileName;/// File name of the imported game HTML file (empty when none).
 String get htmlFileName;/// Raw content of the imported game HTML file (empty when none).
 String get htmlContent;/// Patched HTML produced by the last patch run (empty before a run).
 String get patchedContent;/// Suggested download name for the patched file, e.g.
/// `start_game_patched.html`.
 String get patchedFileName;/// Result of the last patch run, keyed by the rule's index in
/// [PatcherConfig.rules]. Only active rules get an entry.
 Map<int, PatchResult> get results;
/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeStateCopyWith<HomeState> get copyWith => _$HomeStateCopyWithImpl<HomeState>(this as HomeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState&&(identical(other.config, config) || other.config == config)&&(identical(other.configFileName, configFileName) || other.configFileName == configFileName)&&(identical(other.htmlFileName, htmlFileName) || other.htmlFileName == htmlFileName)&&(identical(other.htmlContent, htmlContent) || other.htmlContent == htmlContent)&&(identical(other.patchedContent, patchedContent) || other.patchedContent == patchedContent)&&(identical(other.patchedFileName, patchedFileName) || other.patchedFileName == patchedFileName)&&const DeepCollectionEquality().equals(other.results, results));
}


@override
int get hashCode => Object.hash(runtimeType,config,configFileName,htmlFileName,htmlContent,patchedContent,patchedFileName,const DeepCollectionEquality().hash(results));

@override
String toString() {
  return 'HomeState(config: $config, configFileName: $configFileName, htmlFileName: $htmlFileName, htmlContent: $htmlContent, patchedContent: $patchedContent, patchedFileName: $patchedFileName, results: $results)';
}


}

/// @nodoc
abstract mixin class $HomeStateCopyWith<$Res>  {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) _then) = _$HomeStateCopyWithImpl;
@useResult
$Res call({
 PatcherConfig config, String configFileName, String htmlFileName, String htmlContent, String patchedContent, String patchedFileName, Map<int, PatchResult> results
});


$PatcherConfigCopyWith<$Res> get config;

}
/// @nodoc
class _$HomeStateCopyWithImpl<$Res>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._self, this._then);

  final HomeState _self;
  final $Res Function(HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? config = null,Object? configFileName = null,Object? htmlFileName = null,Object? htmlContent = null,Object? patchedContent = null,Object? patchedFileName = null,Object? results = null,}) {
  return _then(_self.copyWith(
config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as PatcherConfig,configFileName: null == configFileName ? _self.configFileName : configFileName // ignore: cast_nullable_to_non_nullable
as String,htmlFileName: null == htmlFileName ? _self.htmlFileName : htmlFileName // ignore: cast_nullable_to_non_nullable
as String,htmlContent: null == htmlContent ? _self.htmlContent : htmlContent // ignore: cast_nullable_to_non_nullable
as String,patchedContent: null == patchedContent ? _self.patchedContent : patchedContent // ignore: cast_nullable_to_non_nullable
as String,patchedFileName: null == patchedFileName ? _self.patchedFileName : patchedFileName // ignore: cast_nullable_to_non_nullable
as String,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as Map<int, PatchResult>,
  ));
}
/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PatcherConfigCopyWith<$Res> get config {
  
  return $PatcherConfigCopyWith<$Res>(_self.config, (value) {
    return _then(_self.copyWith(config: value));
  });
}
}


/// Adds pattern-matching-related methods to [HomeState].
extension HomeStatePatterns on HomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeState value)  $default,){
final _that = this;
switch (_that) {
case _HomeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeState value)?  $default,){
final _that = this;
switch (_that) {
case _HomeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PatcherConfig config,  String configFileName,  String htmlFileName,  String htmlContent,  String patchedContent,  String patchedFileName,  Map<int, PatchResult> results)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.config,_that.configFileName,_that.htmlFileName,_that.htmlContent,_that.patchedContent,_that.patchedFileName,_that.results);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PatcherConfig config,  String configFileName,  String htmlFileName,  String htmlContent,  String patchedContent,  String patchedFileName,  Map<int, PatchResult> results)  $default,) {final _that = this;
switch (_that) {
case _HomeState():
return $default(_that.config,_that.configFileName,_that.htmlFileName,_that.htmlContent,_that.patchedContent,_that.patchedFileName,_that.results);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PatcherConfig config,  String configFileName,  String htmlFileName,  String htmlContent,  String patchedContent,  String patchedFileName,  Map<int, PatchResult> results)?  $default,) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.config,_that.configFileName,_that.htmlFileName,_that.htmlContent,_that.patchedContent,_that.patchedFileName,_that.results);case _:
  return null;

}
}

}

/// @nodoc


class _HomeState extends HomeState {
  const _HomeState({this.config = const PatcherConfig(), this.configFileName = '', this.htmlFileName = '', this.htmlContent = '', this.patchedContent = '', this.patchedFileName = '', final  Map<int, PatchResult> results = const <int, PatchResult>{}}): _results = results,super._();
  

/// The currently loaded patcher configuration (empty when none).
@override@JsonKey() final  PatcherConfig config;
/// File name the configuration was imported from, e.g.
/// `config_morpatcher.json` (empty when none is loaded).
@override@JsonKey() final  String configFileName;
/// File name of the imported game HTML file (empty when none).
@override@JsonKey() final  String htmlFileName;
/// Raw content of the imported game HTML file (empty when none).
@override@JsonKey() final  String htmlContent;
/// Patched HTML produced by the last patch run (empty before a run).
@override@JsonKey() final  String patchedContent;
/// Suggested download name for the patched file, e.g.
/// `start_game_patched.html`.
@override@JsonKey() final  String patchedFileName;
/// Result of the last patch run, keyed by the rule's index in
/// [PatcherConfig.rules]. Only active rules get an entry.
 final  Map<int, PatchResult> _results;
/// Result of the last patch run, keyed by the rule's index in
/// [PatcherConfig.rules]. Only active rules get an entry.
@override@JsonKey() Map<int, PatchResult> get results {
  if (_results is EqualUnmodifiableMapView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_results);
}


/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeStateCopyWith<_HomeState> get copyWith => __$HomeStateCopyWithImpl<_HomeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeState&&(identical(other.config, config) || other.config == config)&&(identical(other.configFileName, configFileName) || other.configFileName == configFileName)&&(identical(other.htmlFileName, htmlFileName) || other.htmlFileName == htmlFileName)&&(identical(other.htmlContent, htmlContent) || other.htmlContent == htmlContent)&&(identical(other.patchedContent, patchedContent) || other.patchedContent == patchedContent)&&(identical(other.patchedFileName, patchedFileName) || other.patchedFileName == patchedFileName)&&const DeepCollectionEquality().equals(other._results, _results));
}


@override
int get hashCode => Object.hash(runtimeType,config,configFileName,htmlFileName,htmlContent,patchedContent,patchedFileName,const DeepCollectionEquality().hash(_results));

@override
String toString() {
  return 'HomeState(config: $config, configFileName: $configFileName, htmlFileName: $htmlFileName, htmlContent: $htmlContent, patchedContent: $patchedContent, patchedFileName: $patchedFileName, results: $results)';
}


}

/// @nodoc
abstract mixin class _$HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$HomeStateCopyWith(_HomeState value, $Res Function(_HomeState) _then) = __$HomeStateCopyWithImpl;
@override @useResult
$Res call({
 PatcherConfig config, String configFileName, String htmlFileName, String htmlContent, String patchedContent, String patchedFileName, Map<int, PatchResult> results
});


@override $PatcherConfigCopyWith<$Res> get config;

}
/// @nodoc
class __$HomeStateCopyWithImpl<$Res>
    implements _$HomeStateCopyWith<$Res> {
  __$HomeStateCopyWithImpl(this._self, this._then);

  final _HomeState _self;
  final $Res Function(_HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? config = null,Object? configFileName = null,Object? htmlFileName = null,Object? htmlContent = null,Object? patchedContent = null,Object? patchedFileName = null,Object? results = null,}) {
  return _then(_HomeState(
config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as PatcherConfig,configFileName: null == configFileName ? _self.configFileName : configFileName // ignore: cast_nullable_to_non_nullable
as String,htmlFileName: null == htmlFileName ? _self.htmlFileName : htmlFileName // ignore: cast_nullable_to_non_nullable
as String,htmlContent: null == htmlContent ? _self.htmlContent : htmlContent // ignore: cast_nullable_to_non_nullable
as String,patchedContent: null == patchedContent ? _self.patchedContent : patchedContent // ignore: cast_nullable_to_non_nullable
as String,patchedFileName: null == patchedFileName ? _self.patchedFileName : patchedFileName // ignore: cast_nullable_to_non_nullable
as String,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as Map<int, PatchResult>,
  ));
}

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PatcherConfigCopyWith<$Res> get config {
  
  return $PatcherConfigCopyWith<$Res>(_self.config, (value) {
    return _then(_self.copyWith(config: value));
  });
}
}

// dart format on
