import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/promotion.dart';

part 'promotion_dto.g.dart';

@JsonSerializable()
class PromotionDto {
  final String? title;
  @JsonKey(name: 'short-copy')
  final String? shortCopy;
  final String? validity;

  PromotionDto({
    this.title,
    this.shortCopy,
    this.validity,
  });

  factory PromotionDto.fromJson(Map<String, dynamic> json) =>
      _$PromotionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionDtoToJson(this);
}

/// DTO to Entity mapper
extension PromotionDtoMapper on PromotionDto {
  /// Convert DTO to domain entity with default values
  Promotion toEntity() => Promotion(
        title: title ?? 'Wakwaw',
        shortCopy: shortCopy ?? '',
        validity: validity ?? '',
      );
}
