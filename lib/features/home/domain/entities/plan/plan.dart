import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/dtos/plan_dto.dart';

part 'plan.freezed.dart';

@freezed
abstract class Plan with _$Plan {
  const Plan._();

  const factory Plan({
    required int id,
    required String name,
    required String tagline,
    required int pricePerDay,
    required int pricePerWeek,
    required int pricePerMonth,
    required String bestFor,
    @Default([]) List<String> terms,
    @Default('FFFFFFFF') String hexColor,
  }) = _Plan;
}

/// Entity to DTO mapper
extension PlanMapper on Plan {
  /// Convert domain entity to DTO
  PlanDto toDto() => PlanDto(
        id: id,
        name: name,
        tagline: tagline,
        pricePerDay: pricePerDay,
        pricePerWeek: pricePerWeek,
        pricePerMonth: pricePerMonth,
        bestFor: bestFor,
        terms: terms,
        hexColor: hexColor,
      );
}
