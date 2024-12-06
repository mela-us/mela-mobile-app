import 'detailed_progress.dart';

class DetailedProgressList {
  final List<DetailedProgress>? detailedProgressList;

  DetailedProgressList({this.detailedProgressList});

  factory DetailedProgressList.fromJson(List<dynamic> json) {
    try {
      List<DetailedProgress> list = json
          .map((item) => DetailedProgress.fromMap(item as Map<String, dynamic>))
          .toList();
      return DetailedProgressList(detailedProgressList: list);
    } catch (e) {
      return DetailedProgressList(detailedProgressList: []);
    }
  }
}
