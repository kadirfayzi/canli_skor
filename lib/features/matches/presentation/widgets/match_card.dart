import 'dart:convert' show jsonEncode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:canli_skor/features/favorites/bloc/favorites_bloc.dart';
import 'package:canli_skor/features/favorites/bloc/favorites_event.dart';
import 'package:canli_skor/features/favorites/bloc/favorites_state.dart';
import 'package:canli_skor/features/matches/data/match_model.dart';

import 'package:canli_skor/core/utils/date_formatter.dart';
import 'package:canli_skor/core/constants/app_colors.dart';

class MatchCard extends StatelessWidget {
  final MatchModel match;

  const MatchCard({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<FavoritesBloc, FavoritesState>(
      buildWhen: (prev, curr) => prev.favorites != curr.favorites,
      builder: (context, state) {
        final isFavorite = state.favorites.any((m) => m.id == match.id);
        return GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/match_detail', arguments: match),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary.withValues(alpha: 0.1), Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(top: 6, child: Text(DateFormatter.formatDate(match.utcDate))),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      children: [
                        Expanded(child: buildTeamColumn(match.homeTeam)),
                        Expanded(
                            child: Text(
                          match.score.displayScore,
                          style: textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        )),
                        Expanded(child: buildTeamColumn(match.awayTeam)),
                      ],
                    ),
                  ),
                  Positioned(top: 0, right: 0, child: buildFavoriteButton(isFavorite, context)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  IconButton buildFavoriteButton(bool isFavorite, BuildContext context) => IconButton(
        icon: AnimatedCrossFade(
          firstChild: const Icon(Icons.favorite_border),
          secondChild: const Icon(Icons.favorite, color: AppColors.error),
          crossFadeState: isFavorite ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
        onPressed: () {
          if (isFavorite) {
            context.read<FavoritesBloc>().add(RemoveFavorite(match.id));
          } else {
            final favoriteLog = {
              'event_name': 'favorite_match',
              'info': {'name': '${match.homeTeam.name}-${match.awayTeam.name}', 'id': match.id},
            };
            debugPrint(jsonEncode(favoriteLog));
            context.read<FavoritesBloc>().add(AddFavorite(match));
          }
        },
      );

  Column buildTeamColumn(Team team) => Column(
        children: [
          Image.network(team.crest, width: 40, height: 40),
          Text(team.name, textAlign: TextAlign.center),
        ],
      );
}
