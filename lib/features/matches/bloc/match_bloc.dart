import 'dart:async' show StreamSubscription;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/match_model.dart';
import '../data/match_repository.dart';
import 'match_event.dart';
import 'match_state.dart';

class MatchBloc extends Bloc<MatchEvent, MatchState> {
  final MatchRepository _matchRepository;
  StreamSubscription<List<MatchModel>>? _matchSubscription;
  String _currentFilter = 'recent';

  MatchBloc(this._matchRepository) : super(const MatchInitial()) {
    on<StartFetchingMatches>(_onStartFetchingMatches);
    on<FilterMatches>(_onFilterMatches);
    on<StopFetchingMatches>(_onStopFetchingMatches);
    on<MatchesReceived>(_onMatchesReceived);
  }

  Future<void> _onStartFetchingMatches(
    StartFetchingMatches event,
    Emitter<MatchState> emit,
  ) async {
    /// If we're already showing matches, don't show loading again
    if (state is! MatchLoaded) {
      emit(const MatchLoading());
    }

    /// Store the requested filter
    _currentFilter = event.filter;

    try {
      /// Cancel any existing subscription
      await _matchSubscription?.cancel();
      _matchSubscription = null;

      /// Process the stream using listen
      _matchSubscription = _matchRepository.fetchLiveMatchesStream().listen(
        (matches) {
          if (!isClosed) {
            /// Add a new event to process the matches
            add(MatchesReceived(matches: matches, filter: _currentFilter));
          }
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(const MatchLoaded(matches: []));
      }
    }
  }

  /// Processes and emits sorted match data when received.
  void _onMatchesReceived(
    MatchesReceived event,
    Emitter<MatchState> emit,
  ) {
    final sortedMatches = [...event.matches];

    /// Sort matches based on the filter (recent or upcoming).
    if (event.filter == 'recent') {
      sortedMatches.sort((a, b) => b.utcDate.compareTo(a.utcDate));
    } else {
      sortedMatches.sort((a, b) => a.utcDate.compareTo(b.utcDate));
    }
    emit(MatchLoaded(matches: sortedMatches));
  }

  /// Filters already loaded matches without fetching again.
  void _onFilterMatches(
    FilterMatches event,
    Emitter<MatchState> emit,
  ) {
    _currentFilter = event.filter;

    if (state is MatchLoaded) {
      final matches = (state as MatchLoaded).matches;
      final filtered = [...matches];
      if (event.filter == 'recent') {
        filtered.sort((a, b) => b.utcDate.compareTo(a.utcDate));
      } else {
        filtered.sort((a, b) => a.utcDate.compareTo(b.utcDate));
      }
      emit(MatchLoaded(matches: filtered));
    }
  }

  /// Stops the stream subscription without changing the state.
  Future<void> _onStopFetchingMatches(
    StopFetchingMatches event,
    Emitter<MatchState> emit,
  ) async {
    await _matchSubscription?.cancel();
    _matchSubscription = null;
  }

  /// Cancel the subscription when the Bloc is closed to prevent memory leaks.
  @override
  Future<void> close() {
    _matchSubscription?.cancel();
    _matchSubscription = null;
    return super.close();
  }
}
