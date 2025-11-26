import 'package:freezed_annotation/freezed_annotation.dart';

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

  /// Calculate total rental days (inclusive, minimum 1)
  int get totalDays {
    if (fromDate == null || toDate == null) return 0;
    // Inclusive calculation: both from and to dates count
    return toDate!.difference(fromDate!).inDays + 1;
  }

  /// Calculate total amount based on price per day
  int totalAmount(int pricePerDay) => totalDays * pricePerDay;

  /// Check if form is valid for submission
  bool get isValid {
    if (fromDate == null) return false;
    if (toDate == null) return false;
    if (toDate!.isBefore(fromDate!)) return false;
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
