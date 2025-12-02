import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/entities/bike.dart';
import '../../states/bike_filter_state.dart';
import '../../states/price_bucket.dart';
import '../../states/range_bucket.dart';
import '../stream/bikes_provider.dart';

part 'bike_filter_provider.g.dart';

@riverpod
class BikeFilter extends _$BikeFilter {
  @override
  BikeFilterState build() {
    // Watch bikes stream and update filtered bikes when data changes
    final bikesAsync = ref.watch(bikesProvider);

    return bikesAsync.when(
      data: (bikes) {
        // Apply filters to the bikes
        final filtered = _filterBikes(bikes, const BikeFilterState());
        return BikeFilterState(filteredBikes: filtered);
      },
      loading: () => const BikeFilterState(isLoading: true),
      error: (error, _) => BikeFilterState(error: error.toString()),
    );
  }

  /// Filter bikes based on current filter criteria
  List<Bike> _filterBikes(List<Bike> allBikes, BikeFilterState filterState) {
    var filtered = allBikes;

    // Apply search filter (case-insensitive substring on model)
    if (filterState.searchQuery.isNotEmpty) {
      final query = filterState.searchQuery.toLowerCase();
      filtered = filtered
          .where((bike) => bike.model.toLowerCase().contains(query))
          .toList();
    }

    // Apply availability filter
    if (filterState.showAvailableOnly) {
      filtered = filtered.where((bike) => bike.isAvailable).toList();
    }

    // Apply price bucket filter
    if (filterState.selectedPriceBucket != null) {
      filtered = filtered
          .where((bike) =>
              filterState.selectedPriceBucket!.contains(bike.pricePerDay))
          .toList();
    }

    // Apply range bucket filter
    if (filterState.selectedRangeBucket != null) {
      filtered = filtered
          .where(
              (bike) => filterState.selectedRangeBucket!.contains(bike.rangeKm))
          .toList();
    }

    return filtered;
  }

  /// Update search query and reapply filters
  void setSearchQuery(String query) {
    final bikesAsync = ref.read(bikesProvider);
    bikesAsync.whenData((bikes) {
      final filtered = _filterBikes(
        bikes,
        state.copyWith(searchQuery: query.trim()),
      );
      state = state.copyWith(
        searchQuery: query.trim(),
        filteredBikes: filtered,
      );
    });
  }

  /// Toggle availability filter and reapply filters
  void setShowAvailableOnly(bool value) {
    final bikesAsync = ref.read(bikesProvider);
    bikesAsync.whenData((bikes) {
      final filtered = _filterBikes(
        bikes,
        state.copyWith(showAvailableOnly: value),
      );
      state = state.copyWith(
        showAvailableOnly: value,
        filteredBikes: filtered,
      );
    });
  }

  /// Set price bucket filter and reapply filters
  void setPriceBucket(PriceBucket? bucket) {
    final bikesAsync = ref.read(bikesProvider);
    bikesAsync.whenData((bikes) {
      final filtered = _filterBikes(
        bikes,
        state.copyWith(selectedPriceBucket: bucket),
      );
      state = state.copyWith(
        selectedPriceBucket: bucket,
        filteredBikes: filtered,
      );
    });
  }

  /// Set range bucket filter and reapply filters
  void setRangeBucket(RangeBucket? bucket) {
    final bikesAsync = ref.read(bikesProvider);
    bikesAsync.whenData((bikes) {
      final filtered = _filterBikes(
        bikes,
        state.copyWith(selectedRangeBucket: bucket),
      );
      state = state.copyWith(
        selectedRangeBucket: bucket,
        filteredBikes: filtered,
      );
    });
  }

  /// Reset all filters to default state and reapply
  void resetFilters() {
    final bikesAsync = ref.read(bikesProvider);
    bikesAsync.whenData((bikes) {
      final filtered = _filterBikes(bikes, const BikeFilterState());
      state = BikeFilterState(filteredBikes: filtered);
    });
  }

  /// Apply multiple filters at once (for mobile Apply button)
  void applyFilters({
    String? searchQuery,
    bool? showAvailableOnly,
    PriceBucket? priceBucket,
    RangeBucket? rangeBucket,
  }) {
    final bikesAsync = ref.read(bikesProvider);
    bikesAsync.whenData((bikes) {
      final newFilterState = BikeFilterState(
        searchQuery: searchQuery ?? state.searchQuery,
        showAvailableOnly: showAvailableOnly ?? state.showAvailableOnly,
        selectedPriceBucket: priceBucket,
        selectedRangeBucket: rangeBucket,
      );
      final filtered = _filterBikes(bikes, newFilterState);
      state = newFilterState.copyWith(filteredBikes: filtered);
    });
  }
}
