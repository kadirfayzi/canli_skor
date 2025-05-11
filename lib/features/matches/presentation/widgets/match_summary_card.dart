import 'package:flutter/material.dart';
import 'package:canli_skor/features/matches/data/match_model.dart';
import 'package:canli_skor/core/constants/app_colors.dart';
import 'team_column.dart';

class MatchSummaryCard extends StatelessWidget {
  final MatchModel match;

  const MatchSummaryCard({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      color: AppColors.cardLight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: TeamColumn(team: match.homeTeam)),
                Expanded(
                  child: Text(
                    match.score.displayScore,
                    style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(child: TeamColumn(team: match.awayTeam)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
