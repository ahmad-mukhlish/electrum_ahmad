import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/price_formatter.dart';
import '../../../domain/entities/rent.dart';

part 'rent_history_item_state.freezed.dart';

@freezed
abstract class RentHistoryItemState with _$RentHistoryItemState {
  const RentHistoryItemState._();

  const factory RentHistoryItemState({
    required Rent rent,
    required String formattedDateRange,
    required int totalDays,
    required String formattedPrice,
    required String statusLabel,
    required String statusColorKey,
  }) = _RentHistoryItemState;

  factory RentHistoryItemState.fromEntity(Rent rent) {
    return RentHistoryItemState(
      rent: rent,
      formattedDateRange: _formatDateRange(rent.fromDate, rent.toDate),
      totalDays: rent.totalDays,
      formattedPrice: formatPriceToRupiah(rent.totalAmount),
      statusLabel: _getStatusLabel(rent.status),
      statusColorKey: _getStatusColorKey(rent.status),
    );
  }

  /// Format date range as "12 Jan - 15 Jan 2025"
  static String _formatDateRange(DateTime fromDate, DateTime toDate) {
    final dateFormat = DateFormat('dd MMM');
    final yearFormat = DateFormat('yyyy');

    if (fromDate.year == toDate.year && fromDate.month == toDate.month) {
      // Same month and year: "12 - 15 Jan 2025"
      return '${fromDate.day} - ${toDate.day} ${dateFormat.format(toDate).split(' ')[1]} ${yearFormat.format(toDate)}';
    } else if (fromDate.year == toDate.year) {
      // Same year: "12 Jan - 15 Feb 2025"
      return '${dateFormat.format(fromDate)} - ${dateFormat.format(toDate)} ${yearFormat.format(toDate)}';
    } else {
      // Different years: "28 Dec 2024 - 2 Jan 2025"
      return '${dateFormat.format(fromDate)} ${yearFormat.format(fromDate)} - ${dateFormat.format(toDate)} ${yearFormat.format(toDate)}';
    }
  }

  /// Get status label from status string
  static String _getStatusLabel(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Pending';
      case 'confirmed':
        return 'Confirmed';
      case 'completed':
        return 'Completed';
      default:
        return 'Unknown';
    }
  }

  /// Get status color key for ColorScheme
  /// Returns a string key to be used with ColorScheme
  static String _getStatusColorKey(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'secondary';
      case 'confirmed':
        return 'primary';
      case 'completed':
        return 'tertiary';
      default:
        return 'onSurfaceVariant';
    }
  }

  /// Helper method to get actual color from ColorScheme
  Color getStatusColor(ColorScheme colorScheme) {
    switch (statusColorKey) {
      case 'secondary':
        return colorScheme.secondary;
      case 'primary':
        return colorScheme.primary;
      case 'tertiary':
        return colorScheme.tertiary;
      default:
        return colorScheme.onSurfaceVariant;
    }
  }
}
