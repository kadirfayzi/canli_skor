import '../data/match_model.dart';

abstract class MatchEvent {
  const MatchEvent();
}

class StartFetchingMatches extends MatchEvent {
  final String filter;

  const StartFetchingMatches({this.filter = 'recent'});
}

class FilterMatches extends MatchEvent {
  final String filter;
  const FilterMatches(this.filter);
}

class StopFetchingMatches extends MatchEvent {
  const StopFetchingMatches();
}

class MatchesReceived extends MatchEvent {
  final List<MatchModel> matches;
  final String filter;

  const MatchesReceived({required this.matches, required this.filter});
}
