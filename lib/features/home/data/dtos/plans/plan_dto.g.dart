// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanDto _$PlanDtoFromJson(Map<String, dynamic> json) => PlanDto(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  tagline: json['tagline'] as String?,
  pricePerDay: (json['price-per-day'] as num?)?.toInt(),
  pricePerWeek: (json['price-per-week'] as num?)?.toInt(),
  pricePerMonth: (json['price-per-month'] as num?)?.toInt(),
  bestFor: json['best-for'] as String?,
  terms: (json['terms'] as List<dynamic>?)?.map((e) => e as String).toList(),
  hexColor: json['hex-color'] as String?,
);

Map<String, dynamic> _$PlanDtoToJson(PlanDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'tagline': instance.tagline,
  'price-per-day': instance.pricePerDay,
  'price-per-week': instance.pricePerWeek,
  'price-per-month': instance.pricePerMonth,
  'best-for': instance.bestFor,
  'terms': instance.terms,
  'hex-color': instance.hexColor,
};
