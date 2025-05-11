import 'package:canli_skor/features/matches/data/match_model.dart';

abstract class FavoritesEvent {
  const FavoritesEvent();
}

class AddFavorite extends FavoritesEvent {
  final MatchModel match;
  const AddFavorite(this.match);
}

class RemoveFavorite extends FavoritesEvent {
  final String matchId;
  const RemoveFavorite(this.matchId);
}

class LoadFavorites extends FavoritesEvent {
  const LoadFavorites();
}
