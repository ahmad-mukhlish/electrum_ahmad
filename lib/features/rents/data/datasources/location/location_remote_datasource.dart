import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/services/api/api_service.dart';
import '../../dtos/reverse_geocoding_response_dto.dart';

part 'location_remote_datasource.g.dart';

const _nominatimBaseUrl = 'https://nominatim.openstreetmap.org';
const _reversePath = '$_nominatimBaseUrl/reverse';
const _userAgentHeader = 'electrum-ahmad-app';

@riverpod
LocationRemoteDatasource locationRemoteDatasource(Ref ref) =>
    LocationRemoteDatasource(
      apiService: ref.watch(apiServiceProvider),
    );

class LocationRemoteDatasource {
  LocationRemoteDatasource({required ApiService apiService})
      : _apiService = apiService;

  final ApiService _apiService;

  Future<ReverseGeocodingResponseDto?> reverseGeocode({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        path: _reversePath,
        queryParameters: <String, dynamic>{
          'format': 'jsonv2',
          'lat': latitude,
          'lon': longitude,
        },
        options: Options(
          headers: <String, String>{'User-Agent': _userAgentHeader},
        ),
      );

      final data = response.data;
      if (data == null) return null;

      return ReverseGeocodingResponseDto.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
}
