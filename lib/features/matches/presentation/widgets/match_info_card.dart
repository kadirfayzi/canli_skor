import 'package:canli_skor/core/constants/app_colors.dart';
import 'package:canli_skor/core/utils/date_formatter.dart';
import 'package:canli_skor/features/matches/data/match_model.dart';
import 'package:flutter/material.dart';

import 'info_row.dart';

class MatchInfoCard extends StatelessWidget {
  final MatchModel match;

  const MatchInfoCard({super.key, required this.match});

  static const _divider = Divider(height: 24);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      color: AppColors.cardLight,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InfoRow(
              icon: Icons.calendar_today_outlined,
              label: 'Maç Tarihi',
              value: DateFormatter.formatDate(match.utcDate),
              textTheme: textTheme,
            ),
            _divider,
            InfoRow(
              icon: Icons.emoji_events_outlined,
              label: 'Lig',
              value: match.competition.name,
              textTheme: textTheme,
            ),
            _divider,
            InfoRow(
              icon: Icons.sports_soccer_outlined,
              label: 'Durum',
              value: match.status,
              textTheme: textTheme,
            ),
          ],
        ),
      ),
    );
  }
}
