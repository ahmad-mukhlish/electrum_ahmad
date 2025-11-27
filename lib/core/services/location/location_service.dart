import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_service.g.dart';

@Riverpod(keepAlive: true)
LocationService locationService(Ref ref) => LocationService();

class LocationService {
  Future<LocationPermission> checkPermission() async {
    try {
      return await Geolocator.checkPermission();
    } catch (e) {
      rethrow;
    }
  }

  Future<LocationPermission> requestPermission() async {
    try {
      return await Geolocator.requestPermission();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isLocationServiceEnabled() async {
    try {
      return Geolocator.isLocationServiceEnabled();
    } catch (e) {
      rethrow;
    }
  }

  Future<Position> getCurrentPosition({
    LocationAccuracy accuracy = LocationAccuracy.high,
  }) async {
    try {
      return Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: accuracy),
      );
    } catch (e) {
      rethrow;
    }
  }
}
