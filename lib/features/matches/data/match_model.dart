class MatchModel {
  final String id;
  final Team homeTeam;
  final Team awayTeam;
  final Score score;
  final String status;
  final DateTime utcDate;
  final Competition competition;

  const MatchModel({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.score,
    required this.status,
    required this.utcDate,
    required this.competition,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) => MatchModel(
        id: json['id'].toString(),
        homeTeam: Team.fromJson(json['homeTeam']),
        awayTeam: Team.fromJson(json['awayTeam']),
        score: Score.fromJson(json['score']),
        status: json['status'] ?? 'UNKNOWN',
        utcDate: DateTime.parse(json['utcDate'] ?? DateTime.now()).toLocal(),
        competition: Competition.fromJson(json['competition']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'homeTeam': homeTeam.toJson(),
        'awayTeam': awayTeam.toJson(),
        'score': score.toJson(),
        'status': status,
        'utcDate': utcDate.toIso8601String(),
        'competition': competition.toJson(),
      };
}

class Team {
  final String id;
  final String name;
  final String crest;

  Team({
    required this.id,
    required this.name,
    required this.crest,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json['id'].toString(),
        name: json['name'] ?? 'Unknown',
        crest: json['crest'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'crest': crest,
      };
}

class Score {
  final int? home;
  final int? away;

  Score({required this.home, required this.away});

  factory Score.fromJson(Map<String, dynamic> json) => Score(
        home: json['fullTime']?['home'],
        away: json['fullTime']?['away'],
      );

  Map<String, dynamic> toJson() => {
        'fullTime': {
          'home': home,
          'away': away,
        }
      };

  String get displayScore => '${home ?? 0} - ${away ?? 0}';
}

class Competition {
  final String id;
  final String name;
  final String emblem;

  Competition({
    required this.id,
    required this.name,
    required this.emblem,
  });

  factory Competition.fromJson(Map<String, dynamic> json) => Competition(
        id: json['id'].toString(),
        name: json['name'] ?? 'Unknown',
        emblem: json['emblem'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'emblem': emblem,
      };
}
