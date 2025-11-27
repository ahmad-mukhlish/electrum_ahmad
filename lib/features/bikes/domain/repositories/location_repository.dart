import '../entities/resolved_location.dart';

abstract class LocationRepository {
  Future<bool> requestPermission();

  Future<ResolvedLocation?> resolveCurrentLocation();
}
