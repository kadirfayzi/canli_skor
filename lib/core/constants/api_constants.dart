import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static const String baseUrl = 'https://api.football-data.org/v4/';

  /// API key for football-data.org authentication.
  static String get apiKey => dotenv.env['API_KEY'] ?? '';

  /// Interval for refreshing live match data (every 10 seconds for real-time updates).
  /// api.football-data.org is limited with 5 requests per minute
  static const Duration refreshInterval = Duration(seconds: 10);

  /// Timeout for Dio HTTP requests to prevent hanging (20 seconds).
  static const Duration dioTimeout = Duration(seconds: 20);
}
