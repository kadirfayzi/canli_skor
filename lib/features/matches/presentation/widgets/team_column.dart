import 'package:flutter/material.dart';
import 'package:canli_skor/features/matches/data/match_model.dart';

class TeamColumn extends StatelessWidget {
  final Team team;

  const TeamColumn({super.key, required this.team});

  @override
  Widget build(BuildContext context) => Column(
        spacing: 8,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(team.crest),
          ),
          Text(
            team.name,
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
        ],
      );
}
