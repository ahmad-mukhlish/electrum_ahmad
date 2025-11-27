// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rent_history_item_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RentHistoryItemState {

 Rent get rent; String get formattedDateRange; int get totalDays; String get formattedPrice; String get statusLabel; String get statusColorKey;
/// Create a copy of RentHistoryItemState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RentHistoryItemStateCopyWith<RentHistoryItemState> get copyWith => _$RentHistoryItemStateCopyWithImpl<RentHistoryItemState>(this as RentHistoryItemState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RentHistoryItemState&&(identical(other.rent, rent) || other.rent == rent)&&(identical(other.formattedDateRange, formattedDateRange) || other.formattedDateRange == formattedDateRange)&&(identical(other.totalDays, totalDays) || other.totalDays == totalDays)&&(identical(other.formattedPrice, formattedPrice) || other.formattedPrice == formattedPrice)&&(identical(other.statusLabel, statusLabel) || other.statusLabel == statusLabel)&&(identical(other.statusColorKey, statusColorKey) || other.statusColorKey == statusColorKey));
}


@override
int get hashCode => Object.hash(runtimeType,rent,formattedDateRange,totalDays,formattedPrice,statusLabel,statusColorKey);

@override
String toString() {
  return 'RentHistoryItemState(rent: $rent, formattedDateRange: $formattedDateRange, totalDays: $totalDays, formattedPrice: $formattedPrice, statusLabel: $statusLabel, statusColorKey: $statusColorKey)';
}


}

/// @nodoc
abstract mixin class $RentHistoryItemStateCopyWith<$Res>  {
  factory $RentHistoryItemStateCopyWith(RentHistoryItemState value, $Res Function(RentHistoryItemState) _then) = _$RentHistoryItemStateCopyWithImpl;
@useResult
$Res call({
 Rent rent, String formattedDateRange, int totalDays, String formattedPrice, String statusLabel, String statusColorKey
});


$RentCopyWith<$Res> get rent;

}
/// @nodoc
class _$RentHistoryItemStateCopyWithImpl<$Res>
    implements $RentHistoryItemStateCopyWith<$Res> {
  _$RentHistoryItemStateCopyWithImpl(this._self, this._then);

  final RentHistoryItemState _self;
  final $Res Function(RentHistoryItemState) _then;

/// Create a copy of RentHistoryItemState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rent = null,Object? formattedDateRange = null,Object? totalDays = null,Object? formattedPrice = null,Object? statusLabel = null,Object? statusColorKey = null,}) {
  return _then(_self.copyWith(
rent: null == rent ? _self.rent : rent // ignore: cast_nullable_to_non_nullable
as Rent,formattedDateRange: null == formattedDateRange ? _self.formattedDateRange : formattedDateRange // ignore: cast_nullable_to_non_nullable
as String,totalDays: null == totalDays ? _self.totalDays : totalDays // ignore: cast_nullable_to_non_nullable
as int,formattedPrice: null == formattedPrice ? _self.formattedPrice : formattedPrice // ignore: cast_nullable_to_non_nullable
as String,statusLabel: null == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String,statusColorKey: null == statusColorKey ? _self.statusColorKey : statusColorKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of RentHistoryItemState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RentCopyWith<$Res> get rent {
  
  return $RentCopyWith<$Res>(_self.rent, (value) {
    return _then(_self.copyWith(rent: value));
  });
}
}


/// Adds pattern-matching-related methods to [RentHistoryItemState].
extension RentHistoryItemStatePatterns on RentHistoryItemState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RentHistoryItemState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RentHistoryItemState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RentHistoryItemState value)  $default,){
final _that = this;
switch (_that) {
case _RentHistoryItemState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RentHistoryItemState value)?  $default,){
final _that = this;
switch (_that) {
case _RentHistoryItemState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Rent rent,  String formattedDateRange,  int totalDays,  String formattedPrice,  String statusLabel,  String statusColorKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RentHistoryItemState() when $default != null:
return $default(_that.rent,_that.formattedDateRange,_that.totalDays,_that.formattedPrice,_that.statusLabel,_that.statusColorKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Rent rent,  String formattedDateRange,  int totalDays,  String formattedPrice,  String statusLabel,  String statusColorKey)  $default,) {final _that = this;
switch (_that) {
case _RentHistoryItemState():
return $default(_that.rent,_that.formattedDateRange,_that.totalDays,_that.formattedPrice,_that.statusLabel,_that.statusColorKey);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Rent rent,  String formattedDateRange,  int totalDays,  String formattedPrice,  String statusLabel,  String statusColorKey)?  $default,) {final _that = this;
switch (_that) {
case _RentHistoryItemState() when $default != null:
return $default(_that.rent,_that.formattedDateRange,_that.totalDays,_that.formattedPrice,_that.statusLabel,_that.statusColorKey);case _:
  return null;

}
}

}

/// @nodoc


class _RentHistoryItemState extends RentHistoryItemState {
  const _RentHistoryItemState({required this.rent, required this.formattedDateRange, required this.totalDays, required this.formattedPrice, required this.statusLabel, required this.statusColorKey}): super._();
  

@override final  Rent rent;
@override final  String formattedDateRange;
@override final  int totalDays;
@override final  String formattedPrice;
@override final  String statusLabel;
@override final  String statusColorKey;

/// Create a copy of RentHistoryItemState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RentHistoryItemStateCopyWith<_RentHistoryItemState> get copyWith => __$RentHistoryItemStateCopyWithImpl<_RentHistoryItemState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RentHistoryItemState&&(identical(other.rent, rent) || other.rent == rent)&&(identical(other.formattedDateRange, formattedDateRange) || other.formattedDateRange == formattedDateRange)&&(identical(other.totalDays, totalDays) || other.totalDays == totalDays)&&(identical(other.formattedPrice, formattedPrice) || other.formattedPrice == formattedPrice)&&(identical(other.statusLabel, statusLabel) || other.statusLabel == statusLabel)&&(identical(other.statusColorKey, statusColorKey) || other.statusColorKey == statusColorKey));
}


@override
int get hashCode => Object.hash(runtimeType,rent,formattedDateRange,totalDays,formattedPrice,statusLabel,statusColorKey);

@override
String toString() {
  return 'RentHistoryItemState(rent: $rent, formattedDateRange: $formattedDateRange, totalDays: $totalDays, formattedPrice: $formattedPrice, statusLabel: $statusLabel, statusColorKey: $statusColorKey)';
}


}

/// @nodoc
abstract mixin class _$RentHistoryItemStateCopyWith<$Res> implements $RentHistoryItemStateCopyWith<$Res> {
  factory _$RentHistoryItemStateCopyWith(_RentHistoryItemState value, $Res Function(_RentHistoryItemState) _then) = __$RentHistoryItemStateCopyWithImpl;
@override @useResult
$Res call({
 Rent rent, String formattedDateRange, int totalDays, String formattedPrice, String statusLabel, String statusColorKey
});


@override $RentCopyWith<$Res> get rent;

}
/// @nodoc
class __$RentHistoryItemStateCopyWithImpl<$Res>
    implements _$RentHistoryItemStateCopyWith<$Res> {
  __$RentHistoryItemStateCopyWithImpl(this._self, this._then);

  final _RentHistoryItemState _self;
  final $Res Function(_RentHistoryItemState) _then;

/// Create a copy of RentHistoryItemState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rent = null,Object? formattedDateRange = null,Object? totalDays = null,Object? formattedPrice = null,Object? statusLabel = null,Object? statusColorKey = null,}) {
  return _then(_RentHistoryItemState(
rent: null == rent ? _self.rent : rent // ignore: cast_nullable_to_non_nullable
as Rent,formattedDateRange: null == formattedDateRange ? _self.formattedDateRange : formattedDateRange // ignore: cast_nullable_to_non_nullable
as String,totalDays: null == totalDays ? _self.totalDays : totalDays // ignore: cast_nullable_to_non_nullable
as int,formattedPrice: null == formattedPrice ? _self.formattedPrice : formattedPrice // ignore: cast_nullable_to_non_nullable
as String,statusLabel: null == statusLabel ? _self.statusLabel : statusLabel // ignore: cast_nullable_to_non_nullable
as String,statusColorKey: null == statusColorKey ? _self.statusColorKey : statusColorKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of RentHistoryItemState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RentCopyWith<$Res> get rent {
  
  return $RentCopyWith<$Res>(_self.rent, (value) {
    return _then(_self.copyWith(rent: value));
  });
}
}

// dart format on
