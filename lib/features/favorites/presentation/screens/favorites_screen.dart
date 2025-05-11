import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:canli_skor/features/favorites/bloc/favorites_bloc.dart';
import 'package:canli_skor/features/favorites/bloc/favorites_event.dart';
import 'package:canli_skor/features/favorites/bloc/favorites_state.dart';

import 'package:canli_skor/features/matches/presentation/widgets/match_card.dart';
import 'package:canli_skor/features/matches/presentation/widgets/empty_state.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavoritesBloc>().add(const LoadFavorites());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Favori Maçlar'), centerTitle: true),
        body: BlocBuilder<FavoritesBloc, FavoritesState>(
          buildWhen: (prev, curr) => prev.favorites != curr.favorites,
          builder: (context, state) {
            if (state.favorites.isEmpty) {
              return const EmptyState(message: 'Favori maç bulunamadı!');
            }
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.favorites.length,
              itemBuilder: (context, index) => MatchCard(match: state.favorites[index]),
            );
          },
        ),
      );
}
