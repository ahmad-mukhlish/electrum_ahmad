import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/rent/rent.dart';

part 'rent_form_state.freezed.dart';

@freezed
abstract class RentFormState with _$RentFormState {
  const RentFormState._();

  const factory RentFormState({
    DateTime? fromDate,
    DateTime? toDate,
    @Default('') String pickupText,
    double? locationLat,
    double? locationLng,
    @Default('') String contactName,
    @Default('') String contactPhone,
    @Default('') String contactEmail,
  }) = _RentFormState;

  /// Calculate total rental days (delegates to domain entity)
  int get totalDays {
    if (fromDate == null || toDate == null) return 0;
    return Rent.calculateTotalDays(fromDate!, toDate!);
  }

  /// Calculate total amount based on price per day (delegates to domain entity)
  int totalAmount(int pricePerDay) {
    if (fromDate == null || toDate == null) return 0;
    return Rent.calculateTotalAmount(
      fromDate: fromDate!,
      toDate: toDate!,
      pricePerDay: pricePerDay,
    );
  }

  /// Check if form is valid for submission (UI validation)
  bool get isValid {
    if (fromDate == null) return false;
    if (toDate == null) return false;
    // Delegate rental period validation to domain entity
    if (!Rent.isValidRentalPeriod(fromDate!, toDate!)) return false;
    if (pickupText.trim().isEmpty) return false;
    if (contactName.trim().isEmpty) return false;
    if (contactPhone.trim().isEmpty) return false;
    if (contactEmail.trim().isEmpty) return false;
    if (!_isValidEmail(contactEmail)) return false;

    return true;
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email.trim());
  }
}
