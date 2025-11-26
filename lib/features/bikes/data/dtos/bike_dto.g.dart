// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bike_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BikeDto _$BikeDtoFromJson(Map<String, dynamic> json) => BikeDto(
  id: json['id'] as String?,
  model: json['model'] as String?,
  photoUrl: json['photo-url'] as String?,
  rangeKm: (json['range-km'] as num?)?.toInt(),
  isAvailable: json['is-available'] as bool?,
  pricePerDay: (json['price-per-day'] as num?)?.toInt(),
  pickupAreas: (json['pickup-areas'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$BikeDtoToJson(BikeDto instance) => <String, dynamic>{
  'id': instance.id,
  'model': instance.model,
  'photo-url': instance.photoUrl,
  'range-km': instance.rangeKm,
  'is-available': instance.isAvailable,
  'price-per-day': instance.pricePerDay,
  'pickup-areas': instance.pickupAreas,
};
