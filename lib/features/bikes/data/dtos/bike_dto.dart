import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/bike.dart';

part 'bike_dto.g.dart';

@JsonSerializable()
class BikeDto {
  final String? id;
  final String? model;
  @JsonKey(name: 'photo-url')
  final String? photoUrl;
  @JsonKey(name: 'range-km')
  final int? rangeKm;
  @JsonKey(name: 'is-available')
  final bool? isAvailable;
  @JsonKey(name: 'price-per-day')
  final int? pricePerDay;
  @JsonKey(name: 'service-center-areas')
  final List<String>? serviceCenterAreas;

  BikeDto({
    this.id,
    this.model,
    this.photoUrl,
    this.rangeKm,
    this.isAvailable,
    this.pricePerDay,
    this.serviceCenterAreas,
  });

  factory BikeDto.fromJson(Map<String, dynamic> json) =>
      _$BikeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BikeDtoToJson(this);
}

/// DTO to Entity mapper
extension BikeDtoMapper on BikeDto {
  /// Convert DTO to domain entity with default values
  Bike toEntity() => Bike(
        id: id ?? '',
        model: model ?? '',
        photoUrl: photoUrl ?? '',
        rangeKm: rangeKm ?? 0,
        isAvailable: isAvailable ?? false,
        pricePerDay: pricePerDay ?? 0,
        serviceCenterAreas: serviceCenterAreas ?? [],
      );
}
