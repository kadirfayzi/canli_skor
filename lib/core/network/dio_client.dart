import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import 'error_interceptor.dart';

class DioClient {
  static Dio create() {
    final dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: {'X-Auth-Token': ApiConstants.apiKey},
    ));

    /// Add a custom error interceptor to handle errors globally.
    dio.interceptors.add(ErrorInterceptor());
    return dio;
  }
}
