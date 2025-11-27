// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Rent {

 String get id; String get bikeId; String get bikeModel; String? get photoUrl; DateTime get fromDate; DateTime get toDate; String get pickupText; double? get locationLat; double? get locationLng; String get contactName; String get contactPhone; String get contactEmail; int get totalDays; int get pricePerDay; int get totalAmount; DateTime get createdAt; String get status;
/// Create a copy of Rent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RentCopyWith<Rent> get copyWith => _$RentCopyWithImpl<Rent>(this as Rent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Rent&&(identical(other.id, id) || other.id == id)&&(identical(other.bikeId, bikeId) || other.bikeId == bikeId)&&(identical(other.bikeModel, bikeModel) || other.bikeModel == bikeModel)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.pickupText, pickupText) || other.pickupText == pickupText)&&(identical(other.locationLat, locationLat) || other.locationLat == locationLat)&&(identical(other.locationLng, locationLng) || other.locationLng == locationLng)&&(identical(other.contactName, contactName) || other.contactName == contactName)&&(identical(other.contactPhone, contactPhone) || other.contactPhone == contactPhone)&&(identical(other.contactEmail, contactEmail) || other.contactEmail == contactEmail)&&(identical(other.totalDays, totalDays) || other.totalDays == totalDays)&&(identical(other.pricePerDay, pricePerDay) || other.pricePerDay == pricePerDay)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,bikeId,bikeModel,photoUrl,fromDate,toDate,pickupText,locationLat,locationLng,contactName,contactPhone,contactEmail,totalDays,pricePerDay,totalAmount,createdAt,status);

@override
String toString() {
  return 'Rent(id: $id, bikeId: $bikeId, bikeModel: $bikeModel, photoUrl: $photoUrl, fromDate: $fromDate, toDate: $toDate, pickupText: $pickupText, locationLat: $locationLat, locationLng: $locationLng, contactName: $contactName, contactPhone: $contactPhone, contactEmail: $contactEmail, totalDays: $totalDays, pricePerDay: $pricePerDay, totalAmount: $totalAmount, createdAt: $createdAt, status: $status)';
}


}

/// @nodoc
abstract mixin class $RentCopyWith<$Res>  {
  factory $RentCopyWith(Rent value, $Res Function(Rent) _then) = _$RentCopyWithImpl;
@useResult
$Res call({
 String id, String bikeId, String bikeModel, String? photoUrl, DateTime fromDate, DateTime toDate, String pickupText, double? locationLat, double? locationLng, String contactName, String contactPhone, String contactEmail, int totalDays, int pricePerDay, int totalAmount, DateTime createdAt, String status
});




}
/// @nodoc
class _$RentCopyWithImpl<$Res>
    implements $RentCopyWith<$Res> {
  _$RentCopyWithImpl(this._self, this._then);

  final Rent _self;
  final $Res Function(Rent) _then;

/// Create a copy of Rent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? bikeId = null,Object? bikeModel = null,Object? photoUrl = freezed,Object? fromDate = null,Object? toDate = null,Object? pickupText = null,Object? locationLat = freezed,Object? locationLng = freezed,Object? contactName = null,Object? contactPhone = null,Object? contactEmail = null,Object? totalDays = null,Object? pricePerDay = null,Object? totalAmount = null,Object? createdAt = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bikeId: null == bikeId ? _self.bikeId : bikeId // ignore: cast_nullable_to_non_nullable
as String,bikeModel: null == bikeModel ? _self.bikeModel : bikeModel // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as DateTime,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as DateTime,pickupText: null == pickupText ? _self.pickupText : pickupText // ignore: cast_nullable_to_non_nullable
as String,locationLat: freezed == locationLat ? _self.locationLat : locationLat // ignore: cast_nullable_to_non_nullable
as double?,locationLng: freezed == locationLng ? _self.locationLng : locationLng // ignore: cast_nullable_to_non_nullable
as double?,contactName: null == contactName ? _self.contactName : contactName // ignore: cast_nullable_to_non_nullable
as String,contactPhone: null == contactPhone ? _self.contactPhone : contactPhone // ignore: cast_nullable_to_non_nullable
as String,contactEmail: null == contactEmail ? _self.contactEmail : contactEmail // ignore: cast_nullable_to_non_nullable
as String,totalDays: null == totalDays ? _self.totalDays : totalDays // ignore: cast_nullable_to_non_nullable
as int,pricePerDay: null == pricePerDay ? _self.pricePerDay : pricePerDay // ignore: cast_nullable_to_non_nullable
as int,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Rent].
extension RentPatterns on Rent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Rent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Rent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Rent value)  $default,){
final _that = this;
switch (_that) {
case _Rent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Rent value)?  $default,){
final _that = this;
switch (_that) {
case _Rent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String bikeId,  String bikeModel,  String? photoUrl,  DateTime fromDate,  DateTime toDate,  String pickupText,  double? locationLat,  double? locationLng,  String contactName,  String contactPhone,  String contactEmail,  int totalDays,  int pricePerDay,  int totalAmount,  DateTime createdAt,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Rent() when $default != null:
return $default(_that.id,_that.bikeId,_that.bikeModel,_that.photoUrl,_that.fromDate,_that.toDate,_that.pickupText,_that.locationLat,_that.locationLng,_that.contactName,_that.contactPhone,_that.contactEmail,_that.totalDays,_that.pricePerDay,_that.totalAmount,_that.createdAt,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String bikeId,  String bikeModel,  String? photoUrl,  DateTime fromDate,  DateTime toDate,  String pickupText,  double? locationLat,  double? locationLng,  String contactName,  String contactPhone,  String contactEmail,  int totalDays,  int pricePerDay,  int totalAmount,  DateTime createdAt,  String status)  $default,) {final _that = this;
switch (_that) {
case _Rent():
return $default(_that.id,_that.bikeId,_that.bikeModel,_that.photoUrl,_that.fromDate,_that.toDate,_that.pickupText,_that.locationLat,_that.locationLng,_that.contactName,_that.contactPhone,_that.contactEmail,_that.totalDays,_that.pricePerDay,_that.totalAmount,_that.createdAt,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String bikeId,  String bikeModel,  String? photoUrl,  DateTime fromDate,  DateTime toDate,  String pickupText,  double? locationLat,  double? locationLng,  String contactName,  String contactPhone,  String contactEmail,  int totalDays,  int pricePerDay,  int totalAmount,  DateTime createdAt,  String status)?  $default,) {final _that = this;
switch (_that) {
case _Rent() when $default != null:
return $default(_that.id,_that.bikeId,_that.bikeModel,_that.photoUrl,_that.fromDate,_that.toDate,_that.pickupText,_that.locationLat,_that.locationLng,_that.contactName,_that.contactPhone,_that.contactEmail,_that.totalDays,_that.pricePerDay,_that.totalAmount,_that.createdAt,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _Rent extends Rent {
  const _Rent({required this.id, required this.bikeId, required this.bikeModel, this.photoUrl, required this.fromDate, required this.toDate, required this.pickupText, this.locationLat, this.locationLng, required this.contactName, required this.contactPhone, required this.contactEmail, required this.totalDays, required this.pricePerDay, required this.totalAmount, required this.createdAt, this.status = 'pending'}): super._();
  

@override final  String id;
@override final  String bikeId;
@override final  String bikeModel;
@override final  String? photoUrl;
@override final  DateTime fromDate;
@override final  DateTime toDate;
@override final  String pickupText;
@override final  double? locationLat;
@override final  double? locationLng;
@override final  String contactName;
@override final  String contactPhone;
@override final  String contactEmail;
@override final  int totalDays;
@override final  int pricePerDay;
@override final  int totalAmount;
@override final  DateTime createdAt;
@override@JsonKey() final  String status;

/// Create a copy of Rent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RentCopyWith<_Rent> get copyWith => __$RentCopyWithImpl<_Rent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Rent&&(identical(other.id, id) || other.id == id)&&(identical(other.bikeId, bikeId) || other.bikeId == bikeId)&&(identical(other.bikeModel, bikeModel) || other.bikeModel == bikeModel)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.fromDate, fromDate) || other.fromDate == fromDate)&&(identical(other.toDate, toDate) || other.toDate == toDate)&&(identical(other.pickupText, pickupText) || other.pickupText == pickupText)&&(identical(other.locationLat, locationLat) || other.locationLat == locationLat)&&(identical(other.locationLng, locationLng) || other.locationLng == locationLng)&&(identical(other.contactName, contactName) || other.contactName == contactName)&&(identical(other.contactPhone, contactPhone) || other.contactPhone == contactPhone)&&(identical(other.contactEmail, contactEmail) || other.contactEmail == contactEmail)&&(identical(other.totalDays, totalDays) || other.totalDays == totalDays)&&(identical(other.pricePerDay, pricePerDay) || other.pricePerDay == pricePerDay)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,id,bikeId,bikeModel,photoUrl,fromDate,toDate,pickupText,locationLat,locationLng,contactName,contactPhone,contactEmail,totalDays,pricePerDay,totalAmount,createdAt,status);

@override
String toString() {
  return 'Rent(id: $id, bikeId: $bikeId, bikeModel: $bikeModel, photoUrl: $photoUrl, fromDate: $fromDate, toDate: $toDate, pickupText: $pickupText, locationLat: $locationLat, locationLng: $locationLng, contactName: $contactName, contactPhone: $contactPhone, contactEmail: $contactEmail, totalDays: $totalDays, pricePerDay: $pricePerDay, totalAmount: $totalAmount, createdAt: $createdAt, status: $status)';
}


}

/// @nodoc
abstract mixin class _$RentCopyWith<$Res> implements $RentCopyWith<$Res> {
  factory _$RentCopyWith(_Rent value, $Res Function(_Rent) _then) = __$RentCopyWithImpl;
@override @useResult
$Res call({
 String id, String bikeId, String bikeModel, String? photoUrl, DateTime fromDate, DateTime toDate, String pickupText, double? locationLat, double? locationLng, String contactName, String contactPhone, String contactEmail, int totalDays, int pricePerDay, int totalAmount, DateTime createdAt, String status
});




}
/// @nodoc
class __$RentCopyWithImpl<$Res>
    implements _$RentCopyWith<$Res> {
  __$RentCopyWithImpl(this._self, this._then);

  final _Rent _self;
  final $Res Function(_Rent) _then;

/// Create a copy of Rent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? bikeId = null,Object? bikeModel = null,Object? photoUrl = freezed,Object? fromDate = null,Object? toDate = null,Object? pickupText = null,Object? locationLat = freezed,Object? locationLng = freezed,Object? contactName = null,Object? contactPhone = null,Object? contactEmail = null,Object? totalDays = null,Object? pricePerDay = null,Object? totalAmount = null,Object? createdAt = null,Object? status = null,}) {
  return _then(_Rent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bikeId: null == bikeId ? _self.bikeId : bikeId // ignore: cast_nullable_to_non_nullable
as String,bikeModel: null == bikeModel ? _self.bikeModel : bikeModel // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,fromDate: null == fromDate ? _self.fromDate : fromDate // ignore: cast_nullable_to_non_nullable
as DateTime,toDate: null == toDate ? _self.toDate : toDate // ignore: cast_nullable_to_non_nullable
as DateTime,pickupText: null == pickupText ? _self.pickupText : pickupText // ignore: cast_nullable_to_non_nullable
as String,locationLat: freezed == locationLat ? _self.locationLat : locationLat // ignore: cast_nullable_to_non_nullable
as double?,locationLng: freezed == locationLng ? _self.locationLng : locationLng // ignore: cast_nullable_to_non_nullable
as double?,contactName: null == contactName ? _self.contactName : contactName // ignore: cast_nullable_to_non_nullable
as String,contactPhone: null == contactPhone ? _self.contactPhone : contactPhone // ignore: cast_nullable_to_non_nullable
as String,contactEmail: null == contactEmail ? _self.contactEmail : contactEmail // ignore: cast_nullable_to_non_nullable
as String,totalDays: null == totalDays ? _self.totalDays : totalDays // ignore: cast_nullable_to_non_nullable
as int,pricePerDay: null == pricePerDay ? _self.pricePerDay : pricePerDay // ignore: cast_nullable_to_non_nullable
as int,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
