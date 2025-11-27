import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/bike.dart';
import 'filter_buckets.dart';

part 'bike_filter_state.freezed.dart';

@freezed
abstract class BikeFilterState with _$BikeFilterState {
  const BikeFilterState._();

  const factory BikeFilterState({
    @Default('') String searchQuery,
    @Default(false) bool showAvailableOnly,
    PriceBucket? selectedPriceBucket,
    RangeBucket? selectedRangeBucket,
    @Default([]) List<Bike> filteredBikes,
    @Default(false) bool isLoading,
    String? error,
  }) = _BikeFilterState;

  /// Check if any filter is currently active
  bool get hasActiveFilters =>
      searchQuery.isNotEmpty ||
      showAvailableOnly ||
      selectedPriceBucket != null ||
      selectedRangeBucket != null;

  /// Count of active filters (for badge display)
  int get activeFilterCount {
    var count = 0;
    if (searchQuery.isNotEmpty) count++;
    if (showAvailableOnly) count++;
    if (selectedPriceBucket != null) count++;
    if (selectedRangeBucket != null) count++;
    return count;
  }
}
