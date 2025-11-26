// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rent_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RentFormState {

 DateTime? get fromDate; DateTime? get toDate; String get pickupText; double? get locationLat; double? get locationLng; String get contactName; String get contactPhone; String get contactEmail;
/// Create a copy of RentFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RentFormStateCopyWith<RentFormState> get copyWith => _$RentFormStateCopyWithImpl<RentFormState>(this as RentFormState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RentFormState&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.pickupText, pickupText) || other.pickupText == pickupText)&&(identical(other.locationLat, locationLat) || other.locationLat == locationLat)&&(identical(other.locationLng, locationLng) || other.locationLng == locationLng)&&(identical(other.contactName, contactName) || other.contactName == contactName)&&(identical(other.contactPhone, contactPhone) || other.contactPhone == contactPhone)&&(identical(other.contactEmail, contactEmail) || other.contactEmail == contactEmail));
}


@override
int get hashCode => Object.hash(runtimeType,fromDate,toDate,pickupText,locationLat,locationLng,contactName,contactPhone,contactEmail);

@override
String toString() {
  return 'RentFormState(fromDate: $fromDate, toDate: $toDate, pickupText: $pickupText, locationLat: $locationLat, locationLng: $locationLng, contactName: $contactName, contactPhone: $contactPhone, contactEmail: $contactEmail)';
}


}

/// @nodoc
abstract mixin class $RentFormStateCopyWith<$Res>  {
  factory $RentFormStateCopyWith(RentFormState value, $Res Function(RentFormState) _then) = _$RentFormStateCopyWithImpl;
@useResult
$Res call({
 DateTime? fromDate, DateTime? toDate, String pickupText, double? locationLat, double? locationLng, String contactName, String contactPhone, String contactEmail
});




}
/// @nodoc
class _$RentFormStateCopyWithImpl<$Res>
    implements $RentFormStateCopyWith<$Res> {
  _$RentFormStateCopyWithImpl(this._self, this._then);

  final RentFormState _self;
  final $Res Function(RentFormState) _then;

/// Create a copy of RentFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fromDate = freezed,Object? toDate = freezed,Object? pickupText = null,Object? locationLat = freezed,Object? locationLng = freezed,Object? contactName = null,Object? contactPhone = null,Object? contactEmail = null,}) {
  return _then(_self.copyWith(
fromDate: freezed == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as DateTime?,toDate: freezed == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as DateTime?,pickupText: null == pickupText ? _self.pickupText : pickupText // ignore: cast_nullable_to_non_nullable
as String,locationLat: freezed == locationLat ? _self.locationLat : locationLat // ignore: cast_nullable_to_non_nullable
as double?,locationLng: freezed == locationLng ? _self.locationLng : locationLng // ignore: cast_nullable_to_non_nullable
as double?,contactName: null == contactName ? _self.contactName : contactName // ignore: cast_nullable_to_non_nullable
as String,contactPhone: null == contactPhone ? _self.contactPhone : contactPhone // ignore: cast_nullable_to_non_nullable
as String,contactEmail: null == contactEmail ? _self.contactEmail : contactEmail // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RentFormState].
extension RentFormStatePatterns on RentFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RentFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RentFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RentFormState value)  $default,){
final _that = this;
switch (_that) {
case _RentFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RentFormState value)?  $default,){
final _that = this;
switch (_that) {
case _RentFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? fromDate,  DateTime? toDate,  String pickupText,  double? locationLat,  double? locationLng,  String contactName,  String contactPhone,  String contactEmail)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RentFormState() when $default != null:
return $default(_that.fromDate,_that.toDate,_that.pickupText,_that.locationLat,_that.locationLng,_that.contactName,_that.contactPhone,_that.contactEmail);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? fromDate,  DateTime? toDate,  String pickupText,  double? locationLat,  double? locationLng,  String contactName,  String contactPhone,  String contactEmail)  $default,) {final _that = this;
switch (_that) {
case _RentFormState():
return $default(_that.fromDate,_that.toDate,_that.pickupText,_that.locationLat,_that.locationLng,_that.contactName,_that.contactPhone,_that.contactEmail);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? fromDate,  DateTime? toDate,  String pickupText,  double? locationLat,  double? locationLng,  String contactName,  String contactPhone,  String contactEmail)?  $default,) {final _that = this;
switch (_that) {
case _RentFormState() when $default != null:
return $default(_that.fromDate,_that.toDate,_that.pickupText,_that.locationLat,_that.locationLng,_that.contactName,_that.contactPhone,_that.contactEmail);case _:
  return null;

}
}

}

/// @nodoc


class _RentFormState extends RentFormState {
  const _RentFormState({this.fromDate, this.toDate, this.pickupText = '', this.locationLat, this.locationLng, this.contactName = '', this.contactPhone = '', this.contactEmail = ''}): super._();
  

@override final  DateTime? fromDate;
@override final  DateTime? toDate;
@override@JsonKey() final  String pickupText;
@override final  double? locationLat;
@override final  double? locationLng;
@override@JsonKey() final  String contactName;
@override@JsonKey() final  String contactPhone;
@override@JsonKey() final  String contactEmail;

/// Create a copy of RentFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RentFormStateCopyWith<_RentFormState> get copyWith => __$RentFormStateCopyWithImpl<_RentFormState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RentFormState&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.pickupText, pickupText) || other.pickupText == pickupText)&&(identical(other.locationLat, locationLat) || other.locationLat == locationLat)&&(identical(other.locationLng, locationLng) || other.locationLng == locationLng)&&(identical(other.contactName, contactName) || other.contactName == contactName)&&(identical(other.contactPhone, contactPhone) || other.contactPhone == contactPhone)&&(identical(other.contactEmail, contactEmail) || other.contactEmail == contactEmail));
}


@override
int get hashCode => Object.hash(runtimeType,fromDate,toDate,pickupText,locationLat,locationLng,contactName,contactPhone,contactEmail);

@override
String toString() {
  return 'RentFormState(fromDate: $fromDate, toDate: $toDate, pickupText: $pickupText, locationLat: $locationLat, locationLng: $locationLng, contactName: $contactName, contactPhone: $contactPhone, contactEmail: $contactEmail)';
}


}

/// @nodoc
abstract mixin class _$RentFormStateCopyWith<$Res> implements $RentFormStateCopyWith<$Res> {
  factory _$RentFormStateCopyWith(_RentFormState value, $Res Function(_RentFormState) _then) = __$RentFormStateCopyWithImpl;
@override @useResult
$Res call({
 DateTime? fromDate, DateTime? toDate, String pickupText, double? locationLat, double? locationLng, String contactName, String contactPhone, String contactEmail
});




}
/// @nodoc
class __$RentFormStateCopyWithImpl<$Res>
    implements _$RentFormStateCopyWith<$Res> {
  __$RentFormStateCopyWithImpl(this._self, this._then);

  final _RentFormState _self;
  final $Res Function(_RentFormState) _then;

/// Create a copy of RentFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fromDate = freezed,Object? toDate = freezed,Object? pickupText = null,Object? locationLat = freezed,Object? locationLng = freezed,Object? contactName = null,Object? contactPhone = null,Object? contactEmail = null,}) {
  return _then(_RentFormState(
fromDate: freezed == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as DateTime?,toDate: freezed == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as DateTime?,pickupText: null == pickupText ? _self.pickupText : pickupText // ignore: cast_nullable_to_non_nullable
as String,locationLat: freezed == locationLat ? _self.locationLat : locationLat // ignore: cast_nullable_to_non_nullable
as double?,locationLng: freezed == locationLng ? _self.locationLng : locationLng // ignore: cast_nullable_to_non_nullable
as double?,contactName: null == contactName ? _self.contactName : contactName // ignore: cast_nullable_to_non_nullable
as String,contactPhone: null == contactPhone ? _self.contactPhone : contactPhone // ignore: cast_nullable_to_non_nullable
as String,contactEmail: null == contactEmail ? _self.contactEmail : contactEmail // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
