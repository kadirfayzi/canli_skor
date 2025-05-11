import '../data/match_model.dart';

abstract class MatchState {
  const MatchState();
}

class MatchInitial extends MatchState {
  const MatchInitial();
}

class MatchLoading extends MatchState {
  const MatchLoading();
}

class MatchLoaded extends MatchState {
  final List<MatchModel> matches;
  const MatchLoaded({required this.matches});
}

class MatchError extends MatchState {
  final String message;
  const MatchError({required this.message});
}
