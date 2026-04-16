import 'package:dio/dio.dart';

import '../errors/app_exception.dart';
import '../storage/prefs/prefs_storage_service.dart';

class ApiClient {

  ApiClient({
    required Dio dio,
    required PrefsStorageService prefsStorageService,
  }) : _dio = dio,
       _prefsStorageService = prefsStorageService;

  final Dio _dio;
  final PrefsStorageService _prefsStorageService;

  Future<Response<T>> get<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final url = await _buildUrl(path);

      return await _dio.get<T>(
        url,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (error) {
      throw _mapDioException(error);
    } catch (_) {
      throw const UnknownException();
    }
  }

  Future<Response<T>> post<T>(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final url = await _buildUrl(path);

      return await _dio.post<T>(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (error) {
      throw _mapDioException(error);
    } catch (_) {
      throw const UnknownException();
    }
  }

  AppException _mapDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();

      case DioExceptionType.connectionError:
        return const NetworkException();

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;

        if (statusCode == 401) {
          return const UnauthorizedException();
        }

        return ServerException(
          message: error.response?.statusMessage,
        );

      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return const UnknownException();
    }
  }

  Future<String> _buildUrl(String path) async {
    final baseUrl = await _requireBaseUrl();

    if (path.startsWith('/')) {
      return '$baseUrl$path';
    }

    return '$baseUrl/$path';
  }

  Future<String> _requireBaseUrl() async {
    final baseUrl = await _prefsStorageService.getBaseUrl();
    if (baseUrl == null || baseUrl.isEmpty) {
      throw Exception('Base URL is not configured');
    }
    return baseUrl;
  }
}
