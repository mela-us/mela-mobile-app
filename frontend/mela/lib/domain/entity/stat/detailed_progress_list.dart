import 'detailed_progress.dart';

class DetailedProgressList{
  final List<DetailedProgress>? detailedProgressList;

  DetailedProgressList({
    this.detailedProgressList,
  });

  factory DetailedProgressList.fromJson(List<dynamic> json) {
    List<DetailedProgress> list = <DetailedProgress>[];
    list = json.map((progress) => DetailedProgress.fromMap(progress)).toList();

    return DetailedProgressList(
      detailedProgressList: list,
    );
  }
}