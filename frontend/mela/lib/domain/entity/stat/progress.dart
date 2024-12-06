import 'detailed_progress_list.dart';

class Progress {
  String? topicName;
  String? levelName;
  int? totalCorrect;
  int? total;
  DetailedProgressList? last7Days;

  double get completion => total != null && total != 0
      ? (totalCorrect ?? 0) / total!
      : double.infinity;

  Progress({
    this.topicName,
    this.levelName,
    this.totalCorrect,
    this.total,
    this.last7Days,
  });

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      topicName: json['topic']?['name'],
      levelName: json['level']?['name'],
      totalCorrect: json['totalCorrectAnswers'] as int?,
      total: json['totalAnswers'] as int?,
      last7Days: json['last7Days'] != null
          ? DetailedProgressList.fromJson(json['last7Days'] as List<dynamic>)
          : DetailedProgressList(detailedProgressList: []),
    );
  }
}
