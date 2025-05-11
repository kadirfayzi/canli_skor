import 'package:dio/dio.dart';
import 'package:canli_skor/core/constants/api_constants.dart';

import 'match_model.dart';

class MatchRepository {
  final Dio _dio;

  MatchRepository(this._dio);

  /// Returns a stream of live matches that updates periodically.
  Stream<List<MatchModel>> fetchLiveMatchesStream() async* {
    yield* Stream.periodic(ApiConstants.refreshInterval, (_) async {
      try {
        final response = await _dio.get(
          'matches',
          queryParameters: {'status': 'LIVE'}, // Only fetch live matches
        );
        return (response.data['matches'] as List).map((json) => MatchModel.fromJson(json)).toList();
      } catch (e) {
        return <MatchModel>[];
      }
    }).asyncMap((future) => future);
  }
}
