import 'package:dio/dio.dart';
import '../../config/app_config.dart';
import 'interceptors/auth_interceptor.dart';

/// Thin wrapper around [Dio], configured with the active [AppConfig]
/// base URL and shared interceptors.
class ApiClient {
  ApiClient(AppConfig config, {String? Function()? readToken})
      : dio = Dio(
          BaseOptions(
            baseUrl: config.baseUrl,
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
          ),
        ) {
    if (readToken != null) {
      dio.interceptors.add(AuthInterceptor(readToken));
    }
  }

  final Dio dio;
}
