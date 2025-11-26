// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'promotion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Promotion {

 String get title; String get shortCopy; String get validity;
/// Create a copy of Promotion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PromotionCopyWith<Promotion> get copyWith => _$PromotionCopyWithImpl<Promotion>(this as Promotion, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Promotion&&(identical(other.title, title) || other.title == title)&&(identical(other.shortCopy, shortCopy) || other.shortCopy == shortCopy)&&(identical(other.validity, validity) || other.validity == validity));
}


@override
int get hashCode => Object.hash(runtimeType,title,shortCopy,validity);

@override
String toString() {
  return 'Promotion(title: $title, shortCopy: $shortCopy, validity: $validity)';
}


}

/// @nodoc
abstract mixin class $PromotionCopyWith<$Res>  {
  factory $PromotionCopyWith(Promotion value, $Res Function(Promotion) _then) = _$PromotionCopyWithImpl;
@useResult
$Res call({
 String title, String shortCopy, String validity
});




}
/// @nodoc
class _$PromotionCopyWithImpl<$Res>
    implements $PromotionCopyWith<$Res> {
  _$PromotionCopyWithImpl(this._self, this._then);

  final Promotion _self;
  final $Res Function(Promotion) _then;

/// Create a copy of Promotion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? shortCopy = null,Object? validity = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,shortCopy: null == shortCopy ? _self.shortCopy : shortCopy // ignore: cast_nullable_to_non_nullable
as String,validity: null == validity ? _self.validity : validity // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Promotion].
extension PromotionPatterns on Promotion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Promotion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Promotion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Promotion value)  $default,){
final _that = this;
switch (_that) {
case _Promotion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Promotion value)?  $default,){
final _that = this;
switch (_that) {
case _Promotion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String shortCopy,  String validity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Promotion() when $default != null:
return $default(_that.title,_that.shortCopy,_that.validity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String shortCopy,  String validity)  $default,) {final _that = this;
switch (_that) {
case _Promotion():
return $default(_that.title,_that.shortCopy,_that.validity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String shortCopy,  String validity)?  $default,) {final _that = this;
switch (_that) {
case _Promotion() when $default != null:
return $default(_that.title,_that.shortCopy,_that.validity);case _:
  return null;

}
}

}

/// @nodoc


class _Promotion extends Promotion {
  const _Promotion({this.title = '', this.shortCopy = '', this.validity = ''}): super._();
  

@override@JsonKey() final  String title;
@override@JsonKey() final  String shortCopy;
@override@JsonKey() final  String validity;

/// Create a copy of Promotion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PromotionCopyWith<_Promotion> get copyWith => __$PromotionCopyWithImpl<_Promotion>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Promotion&&(identical(other.title, title) || other.title == title)&&(identical(other.shortCopy, shortCopy) || other.shortCopy == shortCopy)&&(identical(other.validity, validity) || other.validity == validity));
}


@override
int get hashCode => Object.hash(runtimeType,title,shortCopy,validity);

@override
String toString() {
  return 'Promotion(title: $title, shortCopy: $shortCopy, validity: $validity)';
}


}

/// @nodoc
abstract mixin class _$PromotionCopyWith<$Res> implements $PromotionCopyWith<$Res> {
  factory _$PromotionCopyWith(_Promotion value, $Res Function(_Promotion) _then) = __$PromotionCopyWithImpl;
@override @useResult
$Res call({
 String title, String shortCopy, String validity
});




}
/// @nodoc
class __$PromotionCopyWithImpl<$Res>
    implements _$PromotionCopyWith<$Res> {
  __$PromotionCopyWithImpl(this._self, this._then);

  final _Promotion _self;
  final $Res Function(_Promotion) _then;

/// Create a copy of Promotion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? shortCopy = null,Object? validity = null,}) {
  return _then(_Promotion(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,shortCopy: null == shortCopy ? _self.shortCopy : shortCopy // ignore: cast_nullable_to_non_nullable
as String,validity: null == validity ? _self.validity : validity // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
