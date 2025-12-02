import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_service.g.dart';

@Riverpod(keepAlive: true)
LocationService locationService(Ref ref) => LocationService();

class LocationService {
  //TODO @ahmad-mukhlis shall this being separated since the check permission and request permission is UI only?
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

  //TODO @ahmad-mukhlis this too isn't this violates single responsibility?
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
