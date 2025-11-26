import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_service.g.dart';

@riverpod
LocationService locationService(Ref ref) {
  return LocationService();
}

class LocationService {
  /// Request location permission from the user
  Future<bool> requestLocationPermission() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        return false;
      }

      return permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always;
    } catch (e) {
      return false;
    }
  }

  /// Get current position (lat/lng)
  Future<Position?> getCurrentPosition() async {
    try {
      final hasPermission = await requestLocationPermission();
      if (!hasPermission) return null;

      final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isLocationEnabled) return null;

      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
    } catch (e) {
      return null;
    }
  }

  /// Reverse geocode coordinates to human-readable address
  Future<String?> getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isEmpty) return null;

      final placemark = placemarks.first;

      // Build formatted address from placemark components
      final parts = <String>[];

      if (placemark.street?.isNotEmpty ?? false) {
        parts.add(placemark.street!);
      }

      if (placemark.subLocality?.isNotEmpty ?? false) {
        parts.add(placemark.subLocality!);
      }

      if (placemark.locality?.isNotEmpty ?? false) {
        parts.add(placemark.locality!);
      }

      if (placemark.administrativeArea?.isNotEmpty ?? false) {
        parts.add(placemark.administrativeArea!);
      }

      return parts.isNotEmpty ? parts.join(', ') : null;
    } catch (e) {
      return null;
    }
  }
}
