class DetailedProgress{
  String? date;
  int? count;
  int? correctCount;

  DetailedProgress({
    this.date, this.count, this.correctCount
  });

  factory DetailedProgress.fromMap(Map<String, dynamic> json) => DetailedProgress(
    date: json["date"],
    count: json["totalAnswers"],
    correctCount: json["totalCorrectAnswers"],
  );
}