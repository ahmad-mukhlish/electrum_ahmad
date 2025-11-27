import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/location/location.dart';

part 'reverse_geocoding_response_dto.g.dart';

@JsonSerializable()
class ReverseGeocodingResponseDto {
  ReverseGeocodingResponseDto({
    this.displayName,
  });

  @JsonKey(name: 'display_name')
  final String? displayName;

  factory ReverseGeocodingResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ReverseGeocodingResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ReverseGeocodingResponseDtoToJson(this);
}

extension ReverseGeocodingResponseDtoMapper on ReverseGeocodingResponseDto {
  Location? toEntity({
    required double latitude,
    required double longitude,
  }) {
    final resolvedAddress = displayName;
    if (resolvedAddress == null || resolvedAddress.isEmpty) {
      return null;
    }

    return Location(
      latitude: latitude,
      longitude: longitude,
      address: resolvedAddress,
    );
  }
}
