import '../entities/location/location.dart';

abstract class LocationRepository {
  Future<bool> requestPermission();

  Future<Location?> resolveCurrentLocation();
}
