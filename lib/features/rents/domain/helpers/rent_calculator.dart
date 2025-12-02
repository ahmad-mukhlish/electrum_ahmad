/// Domain helper for rental calculations and validations
/// Contains business logic that is too complex for entity static methods
class RentCalculator {
  /// BUSINESS RULE: Calculate total rental days (inclusive)
  /// Both fromDate and toDate are counted as rental days
  /// Minimum return value is 1 day
  static int calculateTotalDays(DateTime fromDate, DateTime toDate) {
    // Inclusive calculation: both from and to dates count
    return toDate.difference(fromDate).inDays + 1;
  }

  /// BUSINESS RULE: Calculate total rental amount
  /// Formula: totalDays × pricePerDay
  static int calculateTotalAmount({
    required DateTime fromDate,
    required DateTime toDate,
    required int pricePerDay,
  }) {
    final days = calculateTotalDays(fromDate, toDate);
    return days * pricePerDay;
  }

  /// BUSINESS RULE: Validate rental period
  /// toDate must be after or equal to fromDate
  static bool isValidRentalPeriod(DateTime fromDate, DateTime toDate) {
    return !toDate.isBefore(fromDate);
  }
}
