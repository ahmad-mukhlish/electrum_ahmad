// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlanState {

 Plan get plan; double get percentagePlanDiscountWeekly; double get percentagePlanDiscountMonthly; PlanPeriod get selectedPeriod;
/// Create a copy of PlanState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanStateCopyWith<PlanState> get copyWith => _$PlanStateCopyWithImpl<PlanState>(this as PlanState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanState&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.percentagePlanDiscountWeekly, percentagePlanDiscountWeekly) || other.percentagePlanDiscountWeekly == percentagePlanDiscountWeekly)&&(identical(other.percentagePlanDiscountMonthly, percentagePlanDiscountMonthly) || other.percentagePlanDiscountMonthly == percentagePlanDiscountMonthly)&&(identical(other.selectedPeriod, selectedPeriod) || other.selectedPeriod == selectedPeriod));
}


@override
int get hashCode => Object.hash(runtimeType,plan,percentagePlanDiscountWeekly,percentagePlanDiscountMonthly,selectedPeriod);

@override
String toString() {
  return 'PlanState(plan: $plan, percentagePlanDiscountWeekly: $percentagePlanDiscountWeekly, percentagePlanDiscountMonthly: $percentagePlanDiscountMonthly, selectedPeriod: $selectedPeriod)';
}


}

/// @nodoc
abstract mixin class $PlanStateCopyWith<$Res>  {
  factory $PlanStateCopyWith(PlanState value, $Res Function(PlanState) _then) = _$PlanStateCopyWithImpl;
@useResult
$Res call({
 Plan plan, double percentagePlanDiscountWeekly, double percentagePlanDiscountMonthly, PlanPeriod selectedPeriod
});


$PlanCopyWith<$Res> get plan;

}
/// @nodoc
class _$PlanStateCopyWithImpl<$Res>
    implements $PlanStateCopyWith<$Res> {
  _$PlanStateCopyWithImpl(this._self, this._then);

  final PlanState _self;
  final $Res Function(PlanState) _then;

/// Create a copy of PlanState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? plan = null,Object? percentagePlanDiscountWeekly = null,Object? percentagePlanDiscountMonthly = null,Object? selectedPeriod = null,}) {
  return _then(_self.copyWith(
plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as Plan,percentagePlanDiscountWeekly: null == percentagePlanDiscountWeekly ? _self.percentagePlanDiscountWeekly : percentagePlanDiscountWeekly // ignore: cast_nullable_to_non_nullable
as double,percentagePlanDiscountMonthly: null == percentagePlanDiscountMonthly ? _self.percentagePlanDiscountMonthly : percentagePlanDiscountMonthly // ignore: cast_nullable_to_non_nullable
as double,selectedPeriod: null == selectedPeriod ? _self.selectedPeriod : selectedPeriod // ignore: cast_nullable_to_non_nullable
as PlanPeriod,
  ));
}
/// Create a copy of PlanState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanCopyWith<$Res> get plan {
  
  return $PlanCopyWith<$Res>(_self.plan, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlanState].
extension PlanStatePatterns on PlanState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanState value)  $default,){
final _that = this;
switch (_that) {
case _PlanState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanState value)?  $default,){
final _that = this;
switch (_that) {
case _PlanState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Plan plan,  double percentagePlanDiscountWeekly,  double percentagePlanDiscountMonthly,  PlanPeriod selectedPeriod)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanState() when $default != null:
return $default(_that.plan,_that.percentagePlanDiscountWeekly,_that.percentagePlanDiscountMonthly,_that.selectedPeriod);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Plan plan,  double percentagePlanDiscountWeekly,  double percentagePlanDiscountMonthly,  PlanPeriod selectedPeriod)  $default,) {final _that = this;
switch (_that) {
case _PlanState():
return $default(_that.plan,_that.percentagePlanDiscountWeekly,_that.percentagePlanDiscountMonthly,_that.selectedPeriod);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Plan plan,  double percentagePlanDiscountWeekly,  double percentagePlanDiscountMonthly,  PlanPeriod selectedPeriod)?  $default,) {final _that = this;
switch (_that) {
case _PlanState() when $default != null:
return $default(_that.plan,_that.percentagePlanDiscountWeekly,_that.percentagePlanDiscountMonthly,_that.selectedPeriod);case _:
  return null;

}
}

}

/// @nodoc


class _PlanState extends PlanState {
  const _PlanState({required this.plan, required this.percentagePlanDiscountWeekly, required this.percentagePlanDiscountMonthly, this.selectedPeriod = PlanPeriod.monthly}): super._();
  

@override final  Plan plan;
@override final  double percentagePlanDiscountWeekly;
@override final  double percentagePlanDiscountMonthly;
@override@JsonKey() final  PlanPeriod selectedPeriod;

/// Create a copy of PlanState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanStateCopyWith<_PlanState> get copyWith => __$PlanStateCopyWithImpl<_PlanState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanState&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.percentagePlanDiscountWeekly, percentagePlanDiscountWeekly) || other.percentagePlanDiscountWeekly == percentagePlanDiscountWeekly)&&(identical(other.percentagePlanDiscountMonthly, percentagePlanDiscountMonthly) || other.percentagePlanDiscountMonthly == percentagePlanDiscountMonthly)&&(identical(other.selectedPeriod, selectedPeriod) || other.selectedPeriod == selectedPeriod));
}


@override
int get hashCode => Object.hash(runtimeType,plan,percentagePlanDiscountWeekly,percentagePlanDiscountMonthly,selectedPeriod);

@override
String toString() {
  return 'PlanState(plan: $plan, percentagePlanDiscountWeekly: $percentagePlanDiscountWeekly, percentagePlanDiscountMonthly: $percentagePlanDiscountMonthly, selectedPeriod: $selectedPeriod)';
}


}

/// @nodoc
abstract mixin class _$PlanStateCopyWith<$Res> implements $PlanStateCopyWith<$Res> {
  factory _$PlanStateCopyWith(_PlanState value, $Res Function(_PlanState) _then) = __$PlanStateCopyWithImpl;
@override @useResult
$Res call({
 Plan plan, double percentagePlanDiscountWeekly, double percentagePlanDiscountMonthly, PlanPeriod selectedPeriod
});


@override $PlanCopyWith<$Res> get plan;

}
/// @nodoc
class __$PlanStateCopyWithImpl<$Res>
    implements _$PlanStateCopyWith<$Res> {
  __$PlanStateCopyWithImpl(this._self, this._then);

  final _PlanState _self;
  final $Res Function(_PlanState) _then;

/// Create a copy of PlanState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? plan = null,Object? percentagePlanDiscountWeekly = null,Object? percentagePlanDiscountMonthly = null,Object? selectedPeriod = null,}) {
  return _then(_PlanState(
plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as Plan,percentagePlanDiscountWeekly: null == percentagePlanDiscountWeekly ? _self.percentagePlanDiscountWeekly : percentagePlanDiscountWeekly // ignore: cast_nullable_to_non_nullable
as double,percentagePlanDiscountMonthly: null == percentagePlanDiscountMonthly ? _self.percentagePlanDiscountMonthly : percentagePlanDiscountMonthly // ignore: cast_nullable_to_non_nullable
as double,selectedPeriod: null == selectedPeriod ? _self.selectedPeriod : selectedPeriod // ignore: cast_nullable_to_non_nullable
as PlanPeriod,
  ));
}

/// Create a copy of PlanState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanCopyWith<$Res> get plan {
  
  return $PlanCopyWith<$Res>(_self.plan, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}

// dart format on
