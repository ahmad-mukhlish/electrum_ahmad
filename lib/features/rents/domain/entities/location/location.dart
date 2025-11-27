import 'package:freezed_annotation/freezed_annotation.dart';

part 'location.freezed.dart';

@freezed
abstract class Location with _$Location {
  const Location._();

  const factory Location({
    required double latitude,
    required double longitude,
    required String address,
  }) = _Location;
}
