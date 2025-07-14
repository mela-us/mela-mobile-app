class Streak {
  final int current;
  final DateTime updatedAt;
  final int longest;

  Streak({
    required this.current,
    required this.updatedAt,
    required this.longest,
  });

  factory Streak.fromJson(Map<String, dynamic> json) {
    return Streak(
      current: json['streakDays'],
      updatedAt: DateTime.parse(json['updatedAt']),
      longest: json['longestStreak'],
    );
  }
}
