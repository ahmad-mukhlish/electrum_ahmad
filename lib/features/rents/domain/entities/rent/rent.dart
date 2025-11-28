import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/dtos/rents/rent_dto.dart';

part 'rent.freezed.dart';

@freezed
abstract class Rent with _$Rent {
  const Rent._();

  const factory Rent({
    required String id,
    required String bikeId,
    required String bikeModel,
    String? photoUrl,
    required DateTime fromDate,
    required DateTime toDate,
    required String pickupText,
    double? locationLat,
    double? locationLng,
    required String contactName,
    required String contactPhone,
    required String contactEmail,
    required int totalDays,
    required int pricePerDay,
    required int totalAmount,
    required DateTime createdAt,
    @Default('pending') String status,
  }) = _Rent;

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

/// Entity to DTO mapper
extension RentMapper on Rent {
  RentDto toDto() => RentDto(
        id: id,
        bikeId: bikeId,
        bikeModel: bikeModel,
        photoUrl: photoUrl,
        fromDate: Timestamp.fromDate(fromDate),
        toDate: Timestamp.fromDate(toDate),
        pickupText: pickupText,
        locationLat: locationLat,
        locationLng: locationLng,
        contactName: contactName,
        contactPhone: contactPhone,
        contactEmail: contactEmail,
        totalDays: totalDays,
        pricePerDay: pricePerDay,
        totalAmount: totalAmount,
        createdAt: Timestamp.fromDate(createdAt),
        status: status,
      );
}
