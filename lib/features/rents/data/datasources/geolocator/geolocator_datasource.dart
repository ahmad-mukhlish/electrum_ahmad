import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:electrum_ahmad/core/services/geolocator/geolocator_service.dart';

part 'geolocator_datasource.g.dart';

@riverpod
GeolocatorDatasource geolocatorDatasource(Ref ref) => GeolocatorDatasource(
      service: ref.watch(geolocatorServiceProvider),
    );

class GeolocatorDatasource {
  GeolocatorDatasource({required GeolocatorService service})
      : _service = service;

  final GeolocatorService _service;

  Future<Position> getCurrentPosition({
    LocationAccuracy accuracy = LocationAccuracy.high,
  }) async {
    try {
      return await _service.getCurrentPosition(accuracy: accuracy);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isServiceEnabled() async {
    try {
      return await _service.isLocationServiceEnabled();
    } catch (e) {
      rethrow;
    }
  }
}
