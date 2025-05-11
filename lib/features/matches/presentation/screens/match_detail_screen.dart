import 'package:flutter/material.dart';
import 'package:canli_skor/features/matches/data/match_model.dart';

import '../widgets/match_info_card.dart';
import '../widgets/match_summary_card.dart';

class MatchDetailScreen extends StatelessWidget {
  const MatchDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final match = ModalRoute.of(context)?.settings.arguments as MatchModel;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(match.competition.name),
              background: Image.network(
                match.competition.emblem,
                scale: 1.5,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                spacing: 20,
                children: [
                  MatchSummaryCard(match: match),
                  MatchInfoCard(match: match),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
