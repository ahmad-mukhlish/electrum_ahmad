import 'package:electrum_ahmad/features/rents/data/dtos/location/reverse_geocoding_response_dto.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:electrum_ahmad/features/rents/domain/entities/location/location.dart';
import 'package:electrum_ahmad/features/rents/domain/repositories/location_repository.dart';

import '../../datasources/geolocator/geolocator_datasource.dart';
import '../../datasources/location/location_remote_datasource.dart';

part 'location_repository_impl.g.dart';

@riverpod
LocationRepository locationRepository(Ref ref) => LocationRepositoryImpl(
      geolocatorDatasource: ref.watch(geolocatorDatasourceProvider),
      remoteDatasource: ref.watch(locationRemoteDatasourceProvider),
    );

class LocationRepositoryImpl implements LocationRepository {
  LocationRepositoryImpl({
    required GeolocatorDatasource geolocatorDatasource,
    required LocationRemoteDatasource remoteDatasource,
  })  : _geolocatorDatasource = geolocatorDatasource,
        _remoteDatasource = remoteDatasource;

  final GeolocatorDatasource _geolocatorDatasource;
  final LocationRemoteDatasource _remoteDatasource;

  @override
  Future<Location?> resolveCurrentLocation() async {
    try {
      // Assumes caller (notifier) has already ensured permissions and service enabled
      final position = await _geolocatorDatasource.getCurrentPosition(
        accuracy: LocationAccuracy.high,
      );

      final reverseGeocodeResult = await _remoteDatasource.reverseGeocode(
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
