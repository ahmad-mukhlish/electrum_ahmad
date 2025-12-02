import '../entities/location/location.dart';

abstract class LocationRepository {
  Future<Location?> resolveCurrentLocation();
}
