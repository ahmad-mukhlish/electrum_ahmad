// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bike_filter_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BikeFilterState {

 String get searchQuery; bool get showAvailableOnly; PriceBucket? get selectedPriceBucket; RangeBucket? get selectedRangeBucket; List<Bike> get filteredBikes; bool get isLoading; String? get error;
/// Create a copy of BikeFilterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BikeFilterStateCopyWith<BikeFilterState> get copyWith => _$BikeFilterStateCopyWithImpl<BikeFilterState>(this as BikeFilterState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BikeFilterState&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.showAvailableOnly, showAvailableOnly) || other.showAvailableOnly == showAvailableOnly)&&(identical(other.selectedPriceBucket, selectedPriceBucket) || other.selectedPriceBucket == selectedPriceBucket)&&(identical(other.selectedRangeBucket, selectedRangeBucket) || other.selectedRangeBucket == selectedRangeBucket)&&const DeepCollectionEquality().equals(other.filteredBikes, filteredBikes)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,searchQuery,showAvailableOnly,selectedPriceBucket,selectedRangeBucket,const DeepCollectionEquality().hash(filteredBikes),isLoading,error);

@override
String toString() {
  return 'BikeFilterState(searchQuery: $searchQuery, showAvailableOnly: $showAvailableOnly, selectedPriceBucket: $selectedPriceBucket, selectedRangeBucket: $selectedRangeBucket, filteredBikes: $filteredBikes, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class $BikeFilterStateCopyWith<$Res>  {
  factory $BikeFilterStateCopyWith(BikeFilterState value, $Res Function(BikeFilterState) _then) = _$BikeFilterStateCopyWithImpl;
@useResult
$Res call({
 String searchQuery, bool showAvailableOnly, PriceBucket? selectedPriceBucket, RangeBucket? selectedRangeBucket, List<Bike> filteredBikes, bool isLoading, String? error
});




}
/// @nodoc
class _$BikeFilterStateCopyWithImpl<$Res>
    implements $BikeFilterStateCopyWith<$Res> {
  _$BikeFilterStateCopyWithImpl(this._self, this._then);

  final BikeFilterState _self;
  final $Res Function(BikeFilterState) _then;

/// Create a copy of BikeFilterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? searchQuery = null,Object? showAvailableOnly = null,Object? selectedPriceBucket = freezed,Object? selectedRangeBucket = freezed,Object? filteredBikes = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,showAvailableOnly: null == showAvailableOnly ? _self.showAvailableOnly : showAvailableOnly // ignore: cast_nullable_to_non_nullable
as bool,selectedPriceBucket: freezed == selectedPriceBucket ? _self.selectedPriceBucket : selectedPriceBucket // ignore: cast_nullable_to_non_nullable
as PriceBucket?,selectedRangeBucket: freezed == selectedRangeBucket ? _self.selectedRangeBucket : selectedRangeBucket // ignore: cast_nullable_to_non_nullable
as RangeBucket?,filteredBikes: null == filteredBikes ? _self.filteredBikes : filteredBikes // ignore: cast_nullable_to_non_nullable
as List<Bike>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BikeFilterState].
extension BikeFilterStatePatterns on BikeFilterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BikeFilterState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BikeFilterState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BikeFilterState value)  $default,){
final _that = this;
switch (_that) {
case _BikeFilterState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BikeFilterState value)?  $default,){
final _that = this;
switch (_that) {
case _BikeFilterState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String searchQuery,  bool showAvailableOnly,  PriceBucket? selectedPriceBucket,  RangeBucket? selectedRangeBucket,  List<Bike> filteredBikes,  bool isLoading,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BikeFilterState() when $default != null:
return $default(_that.searchQuery,_that.showAvailableOnly,_that.selectedPriceBucket,_that.selectedRangeBucket,_that.filteredBikes,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String searchQuery,  bool showAvailableOnly,  PriceBucket? selectedPriceBucket,  RangeBucket? selectedRangeBucket,  List<Bike> filteredBikes,  bool isLoading,  String? error)  $default,) {final _that = this;
switch (_that) {
case _BikeFilterState():
return $default(_that.searchQuery,_that.showAvailableOnly,_that.selectedPriceBucket,_that.selectedRangeBucket,_that.filteredBikes,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String searchQuery,  bool showAvailableOnly,  PriceBucket? selectedPriceBucket,  RangeBucket? selectedRangeBucket,  List<Bike> filteredBikes,  bool isLoading,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _BikeFilterState() when $default != null:
return $default(_that.searchQuery,_that.showAvailableOnly,_that.selectedPriceBucket,_that.selectedRangeBucket,_that.filteredBikes,_that.isLoading,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _BikeFilterState extends BikeFilterState {
  const _BikeFilterState({this.searchQuery = '', this.showAvailableOnly = false, this.selectedPriceBucket, this.selectedRangeBucket, final  List<Bike> filteredBikes = const [], this.isLoading = false, this.error}): _filteredBikes = filteredBikes,super._();
  

@override@JsonKey() final  String searchQuery;
@override@JsonKey() final  bool showAvailableOnly;
@override final  PriceBucket? selectedPriceBucket;
@override final  RangeBucket? selectedRangeBucket;
 final  List<Bike> _filteredBikes;
@override@JsonKey() List<Bike> get filteredBikes {
  if (_filteredBikes is EqualUnmodifiableListView) return _filteredBikes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredBikes);
}

@override@JsonKey() final  bool isLoading;
@override final  String? error;

/// Create a copy of BikeFilterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BikeFilterStateCopyWith<_BikeFilterState> get copyWith => __$BikeFilterStateCopyWithImpl<_BikeFilterState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BikeFilterState&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.showAvailableOnly, showAvailableOnly) || other.showAvailableOnly == showAvailableOnly)&&(identical(other.selectedPriceBucket, selectedPriceBucket) || other.selectedPriceBucket == selectedPriceBucket)&&(identical(other.selectedRangeBucket, selectedRangeBucket) || other.selectedRangeBucket == selectedRangeBucket)&&const DeepCollectionEquality().equals(other._filteredBikes, _filteredBikes)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,searchQuery,showAvailableOnly,selectedPriceBucket,selectedRangeBucket,const DeepCollectionEquality().hash(_filteredBikes),isLoading,error);

@override
String toString() {
  return 'BikeFilterState(searchQuery: $searchQuery, showAvailableOnly: $showAvailableOnly, selectedPriceBucket: $selectedPriceBucket, selectedRangeBucket: $selectedRangeBucket, filteredBikes: $filteredBikes, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$BikeFilterStateCopyWith<$Res> implements $BikeFilterStateCopyWith<$Res> {
  factory _$BikeFilterStateCopyWith(_BikeFilterState value, $Res Function(_BikeFilterState) _then) = __$BikeFilterStateCopyWithImpl;
@override @useResult
$Res call({
 String searchQuery, bool showAvailableOnly, PriceBucket? selectedPriceBucket, RangeBucket? selectedRangeBucket, List<Bike> filteredBikes, bool isLoading, String? error
});




}
/// @nodoc
class __$BikeFilterStateCopyWithImpl<$Res>
    implements _$BikeFilterStateCopyWith<$Res> {
  __$BikeFilterStateCopyWithImpl(this._self, this._then);

  final _BikeFilterState _self;
  final $Res Function(_BikeFilterState) _then;

/// Create a copy of BikeFilterState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? searchQuery = null,Object? showAvailableOnly = null,Object? selectedPriceBucket = freezed,Object? selectedRangeBucket = freezed,Object? filteredBikes = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_BikeFilterState(
searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,showAvailableOnly: null == showAvailableOnly ? _self.showAvailableOnly : showAvailableOnly // ignore: cast_nullable_to_non_nullable
as bool,selectedPriceBucket: freezed == selectedPriceBucket ? _self.selectedPriceBucket : selectedPriceBucket // ignore: cast_nullable_to_non_nullable
as PriceBucket?,selectedRangeBucket: freezed == selectedRangeBucket ? _self.selectedRangeBucket : selectedRangeBucket // ignore: cast_nullable_to_non_nullable
as RangeBucket?,filteredBikes: null == filteredBikes ? _self._filteredBikes : filteredBikes // ignore: cast_nullable_to_non_nullable
as List<Bike>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
