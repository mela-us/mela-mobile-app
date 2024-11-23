import 'progress.dart';

class ProgressList{
  final List<Progress>? progressList;

  ProgressList({
    this.progressList,
  });

  factory ProgressList.fromJson(List<dynamic> json) {
    List<Progress> list = <Progress>[];
    list = json.map((progress) => Progress.fromMap(progress)).toList();

    return ProgressList(
      progressList: list,
    );
  }
}