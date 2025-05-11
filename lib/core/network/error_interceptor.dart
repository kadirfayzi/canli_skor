import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show debugPrint;

import 'package:canli_skor/core/constants/api_constants.dart';
import 'exceptions.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options
      ..connectTimeout = ApiConstants.dioTimeout
      ..receiveTimeout = ApiConstants.dioTimeout;
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('RESPONSE[${response.statusCode}] => DATA: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('ERROR[${err.response?.statusCode}] => MESSAGE: ${err.message}');

    final exception = _mapDioErrorToException(err);

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: exception,
        type: err.type,
        response: err.response,
        message: exception.message,
      ),
    );
  }

  AppException _mapDioErrorToException(DioException err) {
    final response = err.response;

    if (response != null && response.data is Map) {
      final data = response.data as Map;
      final message = data['message']?.toString() ?? 'Bilinmeyen bir hata oluştu.';
      return NetworkException(message, statusCode: response.statusCode);
    }

    /// Handle cases where there's no response
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException('Bağlantı zaman aşımına uğradı. Lütfen internetinizi kontrol edin.');
      case DioExceptionType.connectionError:
        return NetworkException('İnternet bağlantısı yok. Lütfen tekrar deneyin.');
      case DioExceptionType.cancel:
        return NetworkException('İstek iptal edildi.');
      default:
        return NetworkException(err.message ?? 'Bilinmeyen bir ağ hatası oluştu.');
    }
  }
}
