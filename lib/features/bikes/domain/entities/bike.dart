import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/dtos/bike_dto.dart';

part 'bike.freezed.dart';

@freezed
abstract class Bike with _$Bike {
  const Bike._();

  const factory Bike({
    required String id,
    required String model,
    required String photoUrl,
    required int rangeKm,
    required bool isAvailable,
    required int pricePerDay,
    @Default([]) List<String> serviceCenterAreas,
  }) = _Bike;
}

/// Entity to DTO mapper
extension BikeMapper on Bike {
  BikeDto toDto() => BikeDto(
        id: id,
        model: model,
        photoUrl: photoUrl,
        rangeKm: rangeKm,
        isAvailable: isAvailable,
        pricePerDay: pricePerDay,
        serviceCenterAreas: serviceCenterAreas,
      );
}
