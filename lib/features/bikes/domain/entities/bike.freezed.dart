// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bike.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Bike {

 String get id; String get model; String get photoUrl; int get rangeKm; bool get isAvailable; int get pricePerDay; List<String> get serviceCenterAreas;
/// Create a copy of Bike
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BikeCopyWith<Bike> get copyWith => _$BikeCopyWithImpl<Bike>(this as Bike, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Bike&&(identical(other.id, id) || other.id == id)&&(identical(other.model, model) || other.model == model)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.rangeKm, rangeKm) || other.rangeKm == rangeKm)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.pricePerDay, pricePerDay) || other.pricePerDay == pricePerDay)&&const DeepCollectionEquality().equals(other.serviceCenterAreas, serviceCenterAreas));
}


@override
int get hashCode => Object.hash(runtimeType,id,model,photoUrl,rangeKm,isAvailable,pricePerDay,const DeepCollectionEquality().hash(serviceCenterAreas));

@override
String toString() {
  return 'Bike(id: $id, model: $model, photoUrl: $photoUrl, rangeKm: $rangeKm, isAvailable: $isAvailable, pricePerDay: $pricePerDay, serviceCenterAreas: $serviceCenterAreas)';
}


}

/// @nodoc
abstract mixin class $BikeCopyWith<$Res>  {
  factory $BikeCopyWith(Bike value, $Res Function(Bike) _then) = _$BikeCopyWithImpl;
@useResult
$Res call({
 String id, String model, String photoUrl, int rangeKm, bool isAvailable, int pricePerDay, List<String> serviceCenterAreas
});




}
/// @nodoc
class _$BikeCopyWithImpl<$Res>
    implements $BikeCopyWith<$Res> {
  _$BikeCopyWithImpl(this._self, this._then);

  final Bike _self;
  final $Res Function(Bike) _then;

/// Create a copy of Bike
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? model = null,Object? photoUrl = null,Object? rangeKm = null,Object? isAvailable = null,Object? pricePerDay = null,Object? serviceCenterAreas = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,photoUrl: null == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String,rangeKm: null == rangeKm ? _self.rangeKm : rangeKm // ignore: cast_nullable_to_non_nullable
as int,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,pricePerDay: null == pricePerDay ? _self.pricePerDay : pricePerDay // ignore: cast_nullable_to_non_nullable
as int,serviceCenterAreas: null == serviceCenterAreas ? _self.serviceCenterAreas : serviceCenterAreas // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Bike].
extension BikePatterns on Bike {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Bike value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Bike() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Bike value)  $default,){
final _that = this;
switch (_that) {
case _Bike():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Bike value)?  $default,){
final _that = this;
switch (_that) {
case _Bike() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String model,  String photoUrl,  int rangeKm,  bool isAvailable,  int pricePerDay,  List<String> serviceCenterAreas)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Bike() when $default != null:
return $default(_that.id,_that.model,_that.photoUrl,_that.rangeKm,_that.isAvailable,_that.pricePerDay,_that.serviceCenterAreas);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String model,  String photoUrl,  int rangeKm,  bool isAvailable,  int pricePerDay,  List<String> serviceCenterAreas)  $default,) {final _that = this;
switch (_that) {
case _Bike():
return $default(_that.id,_that.model,_that.photoUrl,_that.rangeKm,_that.isAvailable,_that.pricePerDay,_that.serviceCenterAreas);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String model,  String photoUrl,  int rangeKm,  bool isAvailable,  int pricePerDay,  List<String> serviceCenterAreas)?  $default,) {final _that = this;
switch (_that) {
case _Bike() when $default != null:
return $default(_that.id,_that.model,_that.photoUrl,_that.rangeKm,_that.isAvailable,_that.pricePerDay,_that.serviceCenterAreas);case _:
  return null;

}
}

}

/// @nodoc


class _Bike extends Bike {
  const _Bike({required this.id, required this.model, required this.photoUrl, required this.rangeKm, required this.isAvailable, required this.pricePerDay, final  List<String> serviceCenterAreas = const []}): _serviceCenterAreas = serviceCenterAreas,super._();
  

@override final  String id;
@override final  String model;
@override final  String photoUrl;
@override final  int rangeKm;
@override final  bool isAvailable;
@override final  int pricePerDay;
 final  List<String> _serviceCenterAreas;
@override@JsonKey() List<String> get serviceCenterAreas {
  if (_serviceCenterAreas is EqualUnmodifiableListView) return _serviceCenterAreas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_serviceCenterAreas);
}


/// Create a copy of Bike
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BikeCopyWith<_Bike> get copyWith => __$BikeCopyWithImpl<_Bike>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Bike&&(identical(other.id, id) || other.id == id)&&(identical(other.model, model) || other.model == model)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.rangeKm, rangeKm) || other.rangeKm == rangeKm)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.pricePerDay, pricePerDay) || other.pricePerDay == pricePerDay)&&const DeepCollectionEquality().equals(other._serviceCenterAreas, _serviceCenterAreas));
}


@override
int get hashCode => Object.hash(runtimeType,id,model,photoUrl,rangeKm,isAvailable,pricePerDay,const DeepCollectionEquality().hash(_serviceCenterAreas));

@override
String toString() {
  return 'Bike(id: $id, model: $model, photoUrl: $photoUrl, rangeKm: $rangeKm, isAvailable: $isAvailable, pricePerDay: $pricePerDay, serviceCenterAreas: $serviceCenterAreas)';
}


}

/// @nodoc
abstract mixin class _$BikeCopyWith<$Res> implements $BikeCopyWith<$Res> {
  factory _$BikeCopyWith(_Bike value, $Res Function(_Bike) _then) = __$BikeCopyWithImpl;
@override @useResult
$Res call({
 String id, String model, String photoUrl, int rangeKm, bool isAvailable, int pricePerDay, List<String> serviceCenterAreas
});




}
/// @nodoc
class __$BikeCopyWithImpl<$Res>
    implements _$BikeCopyWith<$Res> {
  __$BikeCopyWithImpl(this._self, this._then);

  final _Bike _self;
  final $Res Function(_Bike) _then;

/// Create a copy of Bike
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? model = null,Object? photoUrl = null,Object? rangeKm = null,Object? isAvailable = null,Object? pricePerDay = null,Object? serviceCenterAreas = null,}) {
  return _then(_Bike(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,photoUrl: null == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String,rangeKm: null == rangeKm ? _self.rangeKm : rangeKm // ignore: cast_nullable_to_non_nullable
as int,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,pricePerDay: null == pricePerDay ? _self.pricePerDay : pricePerDay // ignore: cast_nullable_to_non_nullable
as int,serviceCenterAreas: null == serviceCenterAreas ? _self._serviceCenterAreas : serviceCenterAreas // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
