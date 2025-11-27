import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/rent/rent.dart';

part 'rent_dto.g.dart';

@JsonSerializable()
class RentDto {
  final String? id;
  @JsonKey(name: 'bike-id')
  final String? bikeId;
  @JsonKey(name: 'bike-model')
  final String? bikeModel;
  @JsonKey(name: 'photo-url')
  final String? photoUrl;
  @JsonKey(
    name: 'from-date',
    fromJson: _timestampFromJson,
    toJson: _timestampToJson,
  )
  final Timestamp? fromDate;
  @JsonKey(
    name: 'to-date',
    fromJson: _timestampFromJson,
    toJson: _timestampToJson,
  )
  final Timestamp? toDate;
  @JsonKey(name: 'pickup-text')
  final String? pickupText;
  @JsonKey(name: 'location-lat')
  final double? locationLat;
  @JsonKey(name: 'location-lng')
  final double? locationLng;
  @JsonKey(name: 'contact-name')
  final String? contactName;
  @JsonKey(name: 'contact-phone')
  final String? contactPhone;
  @JsonKey(name: 'contact-email')
  final String? contactEmail;
  @JsonKey(name: 'total-days')
  final int? totalDays;
  @JsonKey(name: 'price-per-day')
  final int? pricePerDay;
  @JsonKey(name: 'total-amount')
  final int? totalAmount;
  @JsonKey(
    name: 'created-at',
    fromJson: _timestampFromJson,
    toJson: _timestampToJson,
  )
  final Timestamp? createdAt;
  final String? status;

  static Timestamp? _timestampFromJson(dynamic json) {
    if (json == null) return null;
    if (json is Timestamp) return json;
    return null;
  }

  static dynamic _timestampToJson(Timestamp? timestamp) => timestamp;

  RentDto({
    this.id,
    this.bikeId,
    this.bikeModel,
    this.photoUrl,
    this.fromDate,
    this.toDate,
    this.pickupText,
    this.locationLat,
    this.locationLng,
    this.contactName,
    this.contactPhone,
    this.contactEmail,
    this.totalDays,
    this.pricePerDay,
    this.totalAmount,
    this.createdAt,
    this.status,
  });

  factory RentDto.fromJson(Map<String, dynamic> json) =>
      _$RentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RentDtoToJson(this);
}

/// DTO to Entity mapper
extension RentDtoMapper on RentDto {
  /// Convert DTO to domain entity with default values
  Rent toEntity() => Rent(
        id: id ?? '',
        bikeId: bikeId ?? '',
        bikeModel: bikeModel ?? '',
        photoUrl: photoUrl,
        fromDate: fromDate?.toDate() ?? DateTime.now(),
        toDate: toDate?.toDate() ?? DateTime.now(),
        pickupText: pickupText ?? '',
        locationLat: locationLat,
        locationLng: locationLng,
        contactName: contactName ?? '',
        contactPhone: contactPhone ?? '',
        contactEmail: contactEmail ?? '',
        totalDays: totalDays ?? 0,
        pricePerDay: pricePerDay ?? 0,
        totalAmount: totalAmount ?? 0,
        createdAt: createdAt?.toDate() ?? DateTime.now(),
        status: status ?? 'pending',
      );
}
