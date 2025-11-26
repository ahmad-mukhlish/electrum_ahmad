// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rent_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RentDto _$RentDtoFromJson(Map<String, dynamic> json) => RentDto(
  id: json['id'] as String?,
  bikeId: json['bike-id'] as String?,
  fromDate: RentDto._timestampFromJson(json['from-date']),
  toDate: RentDto._timestampFromJson(json['to-date']),
  pickupText: json['pickup-text'] as String?,
  locationLat: (json['location-lat'] as num?)?.toDouble(),
  locationLng: (json['location-lng'] as num?)?.toDouble(),
  contactName: json['contact-name'] as String?,
  contactPhone: json['contact-phone'] as String?,
  contactEmail: json['contact-email'] as String?,
  totalDays: (json['total-days'] as num?)?.toInt(),
  pricePerDay: (json['price-per-day'] as num?)?.toInt(),
  totalAmount: (json['total-amount'] as num?)?.toInt(),
  createdAt: RentDto._timestampFromJson(json['created-at']),
);

Map<String, dynamic> _$RentDtoToJson(RentDto instance) => <String, dynamic>{
  'id': instance.id,
  'bike-id': instance.bikeId,
  'from-date': RentDto._timestampToJson(instance.fromDate),
  'to-date': RentDto._timestampToJson(instance.toDate),
  'pickup-text': instance.pickupText,
  'location-lat': instance.locationLat,
  'location-lng': instance.locationLng,
  'contact-name': instance.contactName,
  'contact-phone': instance.contactPhone,
  'contact-email': instance.contactEmail,
  'total-days': instance.totalDays,
  'price-per-day': instance.pricePerDay,
  'total-amount': instance.totalAmount,
  'created-at': RentDto._timestampToJson(instance.createdAt),
};
