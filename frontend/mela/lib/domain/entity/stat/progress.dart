import 'detailed_progress_list.dart';

class Progress{
  String? topicName;
  String? levelName;
  int? totalCorrect;
  int? total;
  DetailedProgressList? last7Days;

  double get completion => total != 0 ? totalCorrect! / total! : double.infinity;


  Progress({
    this.topicName, this.levelName, this.totalCorrect, this.total, this.last7Days
  });

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      topicName: json['topic']['name'],
      levelName: json['level']['name'],
      totalCorrect: json['totalCorrectAnswers'],
      total: json['totalAnswers'],
      last7Days: DetailedProgressList.fromJson(json['last7Days']),
    );
  }
}