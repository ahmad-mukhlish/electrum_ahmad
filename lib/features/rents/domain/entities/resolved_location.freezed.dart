// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resolved_location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ResolvedLocation {

 double get latitude; double get longitude; String get address;
/// Create a copy of ResolvedLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResolvedLocationCopyWith<ResolvedLocation> get copyWith => _$ResolvedLocationCopyWithImpl<ResolvedLocation>(this as ResolvedLocation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResolvedLocation&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.address, address) || other.address == address));
}


@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,address);

@override
String toString() {
  return 'ResolvedLocation(latitude: $latitude, longitude: $longitude, address: $address)';
}


}

/// @nodoc
abstract mixin class $ResolvedLocationCopyWith<$Res>  {
  factory $ResolvedLocationCopyWith(ResolvedLocation value, $Res Function(ResolvedLocation) _then) = _$ResolvedLocationCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude, String address
});




}
/// @nodoc
class _$ResolvedLocationCopyWithImpl<$Res>
    implements $ResolvedLocationCopyWith<$Res> {
  _$ResolvedLocationCopyWithImpl(this._self, this._then);

  final ResolvedLocation _self;
  final $Res Function(ResolvedLocation) _then;

/// Create a copy of ResolvedLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,Object? address = null,}) {
  return _then(_self.copyWith(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ResolvedLocation].
extension ResolvedLocationPatterns on ResolvedLocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResolvedLocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResolvedLocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResolvedLocation value)  $default,){
final _that = this;
switch (_that) {
case _ResolvedLocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResolvedLocation value)?  $default,){
final _that = this;
switch (_that) {
case _ResolvedLocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double latitude,  double longitude,  String address)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResolvedLocation() when $default != null:
return $default(_that.latitude,_that.longitude,_that.address);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double latitude,  double longitude,  String address)  $default,) {final _that = this;
switch (_that) {
case _ResolvedLocation():
return $default(_that.latitude,_that.longitude,_that.address);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double latitude,  double longitude,  String address)?  $default,) {final _that = this;
switch (_that) {
case _ResolvedLocation() when $default != null:
return $default(_that.latitude,_that.longitude,_that.address);case _:
  return null;

}
}

}

/// @nodoc


class _ResolvedLocation extends ResolvedLocation {
  const _ResolvedLocation({required this.latitude, required this.longitude, required this.address}): super._();
  

@override final  double latitude;
@override final  double longitude;
@override final  String address;

/// Create a copy of ResolvedLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResolvedLocationCopyWith<_ResolvedLocation> get copyWith => __$ResolvedLocationCopyWithImpl<_ResolvedLocation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResolvedLocation&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.address, address) || other.address == address));
}


@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,address);

@override
String toString() {
  return 'ResolvedLocation(latitude: $latitude, longitude: $longitude, address: $address)';
}


}

/// @nodoc
abstract mixin class _$ResolvedLocationCopyWith<$Res> implements $ResolvedLocationCopyWith<$Res> {
  factory _$ResolvedLocationCopyWith(_ResolvedLocation value, $Res Function(_ResolvedLocation) _then) = __$ResolvedLocationCopyWithImpl;
@override @useResult
$Res call({
 double latitude, double longitude, String address
});




}
/// @nodoc
class __$ResolvedLocationCopyWithImpl<$Res>
    implements _$ResolvedLocationCopyWith<$Res> {
  __$ResolvedLocationCopyWithImpl(this._self, this._then);

  final _ResolvedLocation _self;
  final $Res Function(_ResolvedLocation) _then;

/// Create a copy of ResolvedLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,Object? address = null,}) {
  return _then(_ResolvedLocation(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
