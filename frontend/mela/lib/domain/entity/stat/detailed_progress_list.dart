import 'detailed_progress.dart';

class DetailedProgressList{
  final List<DetailedProgress>? detailedProgressList;

  DetailedProgressList({
    this.detailedProgressList,
  });

  factory DetailedProgressList.fromJson(List<dynamic> json) {
    return DetailedProgressList(
      detailedProgressList: json.map((item) => DetailedProgress.fromMap(item)).toList(),
    );
  }
}