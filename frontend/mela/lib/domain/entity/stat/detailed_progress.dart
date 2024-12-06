class DetailedProgress {
  String? date;
  int? count;
  int? correctCount;

  DetailedProgress({
    this.date,
    this.count,
    this.correctCount,
  });

  factory DetailedProgress.fromMap(Map<String, dynamic> json) {
    return DetailedProgress(
      date: json["date"] as String?,
      count: json["totalAnswers"] as int?,
      correctCount: json["totalCorrectAnswers"] as int?,
    );
  }
}