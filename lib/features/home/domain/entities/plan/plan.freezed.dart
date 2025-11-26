// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Plan {

 int get id; String get name; String get tagline; int get pricePerDay; int get pricePerWeek; int get pricePerMonth; String get bestFor; List<String> get terms; String get hexColor;
/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanCopyWith<Plan> get copyWith => _$PlanCopyWithImpl<Plan>(this as Plan, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Plan&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.tagline, tagline) || other.tagline == tagline)&&(identical(other.pricePerDay, pricePerDay) || other.pricePerDay == pricePerDay)&&(identical(other.pricePerWeek, pricePerWeek) || other.pricePerWeek == pricePerWeek)&&(identical(other.pricePerMonth, pricePerMonth) || other.pricePerMonth == pricePerMonth)&&(identical(other.bestFor, bestFor) || other.bestFor == bestFor)&&const DeepCollectionEquality().equals(other.terms, terms)&&(identical(other.hexColor, hexColor) || other.hexColor == hexColor));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,tagline,pricePerDay,pricePerWeek,pricePerMonth,bestFor,const DeepCollectionEquality().hash(terms),hexColor);

@override
String toString() {
  return 'Plan(id: $id, name: $name, tagline: $tagline, pricePerDay: $pricePerDay, pricePerWeek: $pricePerWeek, pricePerMonth: $pricePerMonth, bestFor: $bestFor, terms: $terms, hexColor: $hexColor)';
}


}

/// @nodoc
abstract mixin class $PlanCopyWith<$Res>  {
  factory $PlanCopyWith(Plan value, $Res Function(Plan) _then) = _$PlanCopyWithImpl;
@useResult
$Res call({
 int id, String name, String tagline, int pricePerDay, int pricePerWeek, int pricePerMonth, String bestFor, List<String> terms, String hexColor
});




}
/// @nodoc
class _$PlanCopyWithImpl<$Res>
    implements $PlanCopyWith<$Res> {
  _$PlanCopyWithImpl(this._self, this._then);

  final Plan _self;
  final $Res Function(Plan) _then;

/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? tagline = null,Object? pricePerDay = null,Object? pricePerWeek = null,Object? pricePerMonth = null,Object? bestFor = null,Object? terms = null,Object? hexColor = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,tagline: null == tagline ? _self.tagline : tagline // ignore: cast_nullable_to_non_nullable
as String,pricePerDay: null == pricePerDay ? _self.pricePerDay : pricePerDay // ignore: cast_nullable_to_non_nullable
as int,pricePerWeek: null == pricePerWeek ? _self.pricePerWeek : pricePerWeek // ignore: cast_nullable_to_non_nullable
as int,pricePerMonth: null == pricePerMonth ? _self.pricePerMonth : pricePerMonth // ignore: cast_nullable_to_non_nullable
as int,bestFor: null == bestFor ? _self.bestFor : bestFor // ignore: cast_nullable_to_non_nullable
as String,terms: null == terms ? _self.terms : terms // ignore: cast_nullable_to_non_nullable
as List<String>,hexColor: null == hexColor ? _self.hexColor : hexColor // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Plan].
extension PlanPatterns on Plan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Plan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Plan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Plan value)  $default,){
final _that = this;
switch (_that) {
case _Plan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Plan value)?  $default,){
final _that = this;
switch (_that) {
case _Plan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String tagline,  int pricePerDay,  int pricePerWeek,  int pricePerMonth,  String bestFor,  List<String> terms,  String hexColor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Plan() when $default != null:
return $default(_that.id,_that.name,_that.tagline,_that.pricePerDay,_that.pricePerWeek,_that.pricePerMonth,_that.bestFor,_that.terms,_that.hexColor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String tagline,  int pricePerDay,  int pricePerWeek,  int pricePerMonth,  String bestFor,  List<String> terms,  String hexColor)  $default,) {final _that = this;
switch (_that) {
case _Plan():
return $default(_that.id,_that.name,_that.tagline,_that.pricePerDay,_that.pricePerWeek,_that.pricePerMonth,_that.bestFor,_that.terms,_that.hexColor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String tagline,  int pricePerDay,  int pricePerWeek,  int pricePerMonth,  String bestFor,  List<String> terms,  String hexColor)?  $default,) {final _that = this;
switch (_that) {
case _Plan() when $default != null:
return $default(_that.id,_that.name,_that.tagline,_that.pricePerDay,_that.pricePerWeek,_that.pricePerMonth,_that.bestFor,_that.terms,_that.hexColor);case _:
  return null;

}
}

}

/// @nodoc


class _Plan extends Plan {
  const _Plan({required this.id, required this.name, required this.tagline, required this.pricePerDay, required this.pricePerWeek, required this.pricePerMonth, required this.bestFor, final  List<String> terms = const [], this.hexColor = 'FFFFFFFF'}): _terms = terms,super._();
  

@override final  int id;
@override final  String name;
@override final  String tagline;
@override final  int pricePerDay;
@override final  int pricePerWeek;
@override final  int pricePerMonth;
@override final  String bestFor;
 final  List<String> _terms;
@override@JsonKey() List<String> get terms {
  if (_terms is EqualUnmodifiableListView) return _terms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_terms);
}

@override@JsonKey() final  String hexColor;

/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanCopyWith<_Plan> get copyWith => __$PlanCopyWithImpl<_Plan>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Plan&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.tagline, tagline) || other.tagline == tagline)&&(identical(other.pricePerDay, pricePerDay) || other.pricePerDay == pricePerDay)&&(identical(other.pricePerWeek, pricePerWeek) || other.pricePerWeek == pricePerWeek)&&(identical(other.pricePerMonth, pricePerMonth) || other.pricePerMonth == pricePerMonth)&&(identical(other.bestFor, bestFor) || other.bestFor == bestFor)&&const DeepCollectionEquality().equals(other._terms, _terms)&&(identical(other.hexColor, hexColor) || other.hexColor == hexColor));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,tagline,pricePerDay,pricePerWeek,pricePerMonth,bestFor,const DeepCollectionEquality().hash(_terms),hexColor);

@override
String toString() {
  return 'Plan(id: $id, name: $name, tagline: $tagline, pricePerDay: $pricePerDay, pricePerWeek: $pricePerWeek, pricePerMonth: $pricePerMonth, bestFor: $bestFor, terms: $terms, hexColor: $hexColor)';
}


}

/// @nodoc
abstract mixin class _$PlanCopyWith<$Res> implements $PlanCopyWith<$Res> {
  factory _$PlanCopyWith(_Plan value, $Res Function(_Plan) _then) = __$PlanCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String tagline, int pricePerDay, int pricePerWeek, int pricePerMonth, String bestFor, List<String> terms, String hexColor
});




}
/// @nodoc
class __$PlanCopyWithImpl<$Res>
    implements _$PlanCopyWith<$Res> {
  __$PlanCopyWithImpl(this._self, this._then);

  final _Plan _self;
  final $Res Function(_Plan) _then;

/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? tagline = null,Object? pricePerDay = null,Object? pricePerWeek = null,Object? pricePerMonth = null,Object? bestFor = null,Object? terms = null,Object? hexColor = null,}) {
  return _then(_Plan(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,tagline: null == tagline ? _self.tagline : tagline // ignore: cast_nullable_to_non_nullable
as String,pricePerDay: null == pricePerDay ? _self.pricePerDay : pricePerDay // ignore: cast_nullable_to_non_nullable
as int,pricePerWeek: null == pricePerWeek ? _self.pricePerWeek : pricePerWeek // ignore: cast_nullable_to_non_nullable
as int,pricePerMonth: null == pricePerMonth ? _self.pricePerMonth : pricePerMonth // ignore: cast_nullable_to_non_nullable
as int,bestFor: null == bestFor ? _self.bestFor : bestFor // ignore: cast_nullable_to_non_nullable
as String,terms: null == terms ? _self._terms : terms // ignore: cast_nullable_to_non_nullable
as List<String>,hexColor: null == hexColor ? _self.hexColor : hexColor // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
