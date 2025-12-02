import 'package:intl/intl.dart';

/// Helper class for date formatting utilities
class DateHelper {
  DateHelper._();

  /// Format date as "12 January 2025"
  /// Example: January 15, 2025 -> "15 January 2025"
  static String formatLongDate(DateTime dateTime) {
    final dateFormat = DateFormat('dd MMMM yyyy');
    return dateFormat.format(dateTime);
  }

  /// Format date as "Jan 12, 2025"
  /// Example: January 15, 2025 -> "Jan 15, 2025"
  static String formatMediumDate(DateTime dateTime) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    return dateFormat.format(dateTime);
  }

  /// Format date as "12 Jan"
  /// Example: January 15, 2025 -> "15 Jan"
  static String formatShortDate(DateTime dateTime) {
    final dateFormat = DateFormat('dd MMM');
    return dateFormat.format(dateTime);
  }

  /// Format year as "2025"
  static String formatYear(DateTime dateTime) {
    final yearFormat = DateFormat('yyyy');
    return yearFormat.format(dateTime);
  }

  /// Format date range as "12 Jan - 15 Jan 2025" or "12 - 15 Jan 2025"
  /// Optimizes display based on whether dates are in same month/year
  static String formatDateRange(DateTime fromDate, DateTime toDate) {
    final dateFormat = DateFormat('dd MMM');
    final yearFormat = DateFormat('yyyy');

    if (fromDate.year == toDate.year && fromDate.month == toDate.month) {
      // Same month and year: "12 - 15 Jan 2025"
      return '${fromDate.day} - ${dateFormat.format(toDate)} ${yearFormat.format(toDate)}';
    } else if (fromDate.year == toDate.year) {
      // Same year, different month: "12 Jan - 15 Feb 2025"
      return '${dateFormat.format(fromDate)} - ${dateFormat.format(toDate)} ${yearFormat.format(toDate)}';
    } else {
      // Different years: "25 Dec 2024 - 5 Jan 2025"
      return '${dateFormat.format(fromDate)} ${yearFormat.format(fromDate)} - ${dateFormat.format(toDate)} ${yearFormat.format(toDate)}';
    }
  }
}
