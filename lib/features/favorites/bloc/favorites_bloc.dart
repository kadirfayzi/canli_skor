import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/storage_service.dart';

import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final StorageService storageService;

  FavoritesBloc(this.storageService) : super(const FavoritesInitial()) {
    on<AddFavorite>(_onAddFavorite);
    on<RemoveFavorite>(_onRemoveFavorite);
    on<LoadFavorites>(_onLoadFavorites);
  }

  /// Handler for adding a favorite match.
  Future<void> _onAddFavorite(
    AddFavorite event,
    Emitter<FavoritesState> emit,
  ) async {
    final currentFavorites = state.favorites;
    if (!currentFavorites.any((m) => m.id == event.match.id)) {
      final updated = [...currentFavorites, event.match];
      await storageService.saveFavorites(updated);
      emit(FavoritesLoaded(favorites: updated));
    }
  }

  /// Handler for removing a favorite match by ID.
  Future<void> _onRemoveFavorite(
    RemoveFavorite event,
    Emitter<FavoritesState> emit,
  ) async {
    final updated = state.favorites.where((m) => m.id != event.matchId).toList();
    await storageService.saveFavorites(updated);
    emit(FavoritesLoaded(favorites: updated));
  }

  /// Handler for loading all saved favorites from storage.
  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    final favorites = await storageService.loadFavorites();
    emit(FavoritesLoaded(favorites: favorites));
  }
}
