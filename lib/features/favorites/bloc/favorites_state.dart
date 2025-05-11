import 'package:canli_skor/features/matches/data/match_model.dart';

abstract class FavoritesState {
  final List<MatchModel> favorites;
  const FavoritesState(this.favorites);
}

class FavoritesInitial extends FavoritesState {
  const FavoritesInitial() : super(const []);
}

class FavoritesLoaded extends FavoritesState {
  const FavoritesLoaded({required List<MatchModel> favorites}) : super(favorites);
}
