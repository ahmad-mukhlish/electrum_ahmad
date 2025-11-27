import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_service.g.dart';

@Riverpod(keepAlive: true)
Dio dioClient(Ref ref) => Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        responseType: ResponseType.json,
      ),
    );

@riverpod
ApiService apiService(Ref ref) {
  final dio = ref.watch(dioClientProvider);
  return ApiService(dio: dio);
}

class ApiService {
  ApiService({required Dio dio}) : _dio = dio;

  final Dio _dio;

  Dio get client => _dio;

  void setHeaderToken(String bearerToken) => _dio.options.headers
      .addAll(<String, String>{'Authorization': 'Bearer $bearerToken'});

  Future<Response<T>> get<T>({
    String path = '',
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<T>> post<T>({
    String path = '',
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<T>> put<T>({
    String path = '',
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<T>> delete<T>({
    String path = '',
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }
}
