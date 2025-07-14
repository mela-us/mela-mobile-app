class ScoreRecord {
  String date;
  double score;

  ScoreRecord({
    required this.date,
    required this.score,
  });

  factory ScoreRecord.fromJson(Map<String, dynamic> json) {
    return ScoreRecord(
      date: json['date'],
      score: json['score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'score': score,
    };
  }
}