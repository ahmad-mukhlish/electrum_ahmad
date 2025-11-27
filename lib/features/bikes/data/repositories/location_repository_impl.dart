import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/location/location_service.dart';
import '../../domain/entities/resolved_location.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/location_geocoding_remote_datasource.dart';
import '../dtos/reverse_geocoding_response_dto.dart';

part 'location_repository_impl.g.dart';

@riverpod
LocationRepository locationRepository(Ref ref) => LocationRepositoryImpl(
      platformService: ref.watch(locationServiceProvider),
      geocodingDatasource: ref.watch(locationGeocodingRemoteDatasourceProvider),
    );

class LocationRepositoryImpl implements LocationRepository {
  LocationRepositoryImpl({
    required LocationService platformService,
    required LocationGeocodingRemoteDatasource geocodingDatasource,
  })  : _locationService = platformService,
        _geocodingDatasource = geocodingDatasource;

  final LocationService _locationService;
  final LocationGeocodingRemoteDatasource _geocodingDatasource;

  @override
  Future<bool> requestPermission() async {
    try {
      var permission = await _locationService.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await _locationService.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        return false;
      }

      return permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResolvedLocation?> resolveCurrentLocation() async {
    try {
      final hasPermission = await requestPermission();
      if (!hasPermission) return null;

      final isEnabled = await _locationService.isLocationServiceEnabled();
      if (!isEnabled) return null;

      final position = await _locationService.getCurrentPosition(
        accuracy: LocationAccuracy.high,
      );

      final reverseGeocodeResult =
          await _geocodingDatasource.reverseGeocode(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      return reverseGeocodeResult?.toEntity(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e) {
      rethrow;
    }
  }
}
