import 'dart:convert' show jsonDecode, jsonEncode;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:canli_skor/features/matches/data/match_model.dart';

class StorageService {
  static const String _favoritesKey = 'favorites';

  Future<void> saveFavorites(List<MatchModel> favorites) async {
    final json = favorites.map((m) => jsonEncode(m.toJson())).toList();
    (await SharedPreferences.getInstance()).setStringList(_favoritesKey, json);
  }

  Future<List<MatchModel>> loadFavorites() async {
    final json = (await SharedPreferences.getInstance()).getStringList(_favoritesKey) ?? [];
    return json.map((j) => MatchModel.fromJson(jsonDecode(j))).toList();
  }
}
