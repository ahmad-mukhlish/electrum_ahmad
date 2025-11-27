import 'package:dio/dio.dart';
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
      final dio = Dio(
        BaseOptions(
          baseUrl: 'https://nominatim.openstreetmap.org',
          headers: {
            'User-Agent': 'electrum-ahmad-app',
          },
        ),
      );

      final response = await dio.get<Map<String, dynamic>>(
        '/reverse',
        queryParameters: {
          'format': 'jsonv2',
          'lat': latitude,
          'lon': longitude,
        },
      );

      final address = response.data?['display_name'] as String?;

      if (address == null || address.isEmpty) {
        return null;
      }

      return address;
    } catch (e) {
      return null;
    }
  }

  Future<ResolvedLocation?> resolveCurrentLocation() async {
    try {
      final position = await getCurrentPosition();
      if (position == null) return null;

      final address = await getAddressFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (address == null || address.isEmpty) {
        return null;
      }

      return ResolvedLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        address: address,
      );
    } catch (e) {
      rethrow;
    }
  }
}

class ResolvedLocation {
  ResolvedLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  final double latitude;
  final double longitude;
  final String address;
}
