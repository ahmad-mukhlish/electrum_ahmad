// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromotionDto _$PromotionDtoFromJson(Map<String, dynamic> json) => PromotionDto(
  title: json['title'] as String?,
  shortCopy: json['short-copy'] as String?,
  validity: json['validity'] as String?,
);

Map<String, dynamic> _$PromotionDtoToJson(PromotionDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'short-copy': instance.shortCopy,
      'validity': instance.validity,
    };
