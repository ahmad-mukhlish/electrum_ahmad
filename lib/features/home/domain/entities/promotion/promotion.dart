import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/dtos/promotion_dto.dart';

part 'promotion.freezed.dart';

@freezed
abstract class Promotion with _$Promotion {
  const Promotion._();

  const factory Promotion({
    @Default('') String title,
    @Default('') String shortCopy,
    @Default('') String validity,
  }) = _Promotion;
}

/// Entity to DTO mapper
extension PromotionMapper on Promotion {
  /// Convert domain entity to DTO
  PromotionDto toDto() => PromotionDto(
        title: title,
        shortCopy: shortCopy,
        validity: validity,
      );
}
