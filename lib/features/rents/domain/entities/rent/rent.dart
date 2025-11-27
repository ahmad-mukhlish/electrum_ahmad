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
  }) = _Rent;
}

/// Entity to DTO mapper
extension RentMapper on Rent {
  RentDto toDto() => RentDto(
        id: id,
        bikeId: bikeId,
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
      );
}
