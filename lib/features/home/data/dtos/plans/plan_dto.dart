import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/plan/plan.dart';
part 'plan_dto.g.dart';

@JsonSerializable()
class PlanDto {
  final int? id;
  final String? name;
  final String? tagline;
  @JsonKey(name: 'price-per-day')
  final int? pricePerDay;
  @JsonKey(name: 'price-per-week')
  final int? pricePerWeek;
  @JsonKey(name: 'price-per-month')
  final int? pricePerMonth;
  @JsonKey(name: 'best-for')
  final String? bestFor;
  final List<String>? terms;
  @JsonKey(name: 'hex-color')
  final String? hexColor;

  PlanDto({
    this.id,
    this.name,
    this.tagline,
    this.pricePerDay,
    this.pricePerWeek,
    this.pricePerMonth,
    this.bestFor,
    this.terms,
    this.hexColor,
  });

  factory PlanDto.fromJson(Map<String, dynamic> json) =>
      _$PlanDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PlanDtoToJson(this);
}

/// DTO to Entity mapper
extension PlanDtoMapper on PlanDto {
  /// Convert DTO to domain entity with default values
  Plan toEntity() => Plan(
        id: id ?? 0,
        name: name ?? '',
        tagline: tagline ?? '',
        pricePerDay: pricePerDay ?? 0,
        pricePerWeek: pricePerWeek ?? 0,
        pricePerMonth: pricePerMonth ?? 0,
        bestFor: bestFor ?? '',
        terms: terms ?? [],
        hexColor: hexColor ?? 'FFFFFFFF',
      );
}
