/// Base exception for all app-specific errors
abstract class AppException implements Exception {
  final String message;
  AppException(this.message);

  @override
  String toString() => message;
}

/// Represents network/API-related errors with optional statusCode
class NetworkException extends AppException {
  final int? statusCode;
  NetworkException(super.message, {this.statusCode});
}

/// Represents app-level logic or operational failures
class OperationException extends AppException {
  OperationException(super.message);
}
