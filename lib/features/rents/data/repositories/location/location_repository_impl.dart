import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:electrum_ahmad/core/services/location/location_service.dart';
import 'package:electrum_ahmad/features/rents/domain/entities/resolved_location.dart';
import 'package:electrum_ahmad/features/rents/domain/repositories/location_repository.dart';

import '../../datasources/location/location_remote_datasource.dart';
import '../../dtos/location/reverse_geocoding_response_dto.dart';

part 'location_repository_impl.g.dart';

@riverpod
LocationRepository locationRepository(Ref ref) => LocationRepositoryImpl(
      platformService: ref.watch(locationServiceProvider),
      locationDatasource: ref.watch(locationRemoteDatasourceProvider),
    );

class LocationRepositoryImpl implements LocationRepository {
  LocationRepositoryImpl({
    required LocationService platformService,
    required LocationRemoteDatasource locationDatasource,
  })  : _locationService = platformService,
        _locationDatasource = locationDatasource;

  final LocationService _locationService;
  final LocationRemoteDatasource _locationDatasource;

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
          await _locationDatasource.reverseGeocode(
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
