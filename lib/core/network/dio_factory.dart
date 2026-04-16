import 'package:dio/dio.dart';

class DioFactory {
  static const int connectionTimeOut = 30;

  Dio create() {
    return Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: connectionTimeOut),
        receiveTimeout: const Duration(seconds: connectionTimeOut),
        sendTimeout: const Duration(seconds: connectionTimeOut),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        responseType: ResponseType.json,
      ),
    );
  }
}
