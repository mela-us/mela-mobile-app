import 'progress.dart';

class ProgressList {
  final List<Progress>? progressList;

  ProgressList({this.progressList});

  factory ProgressList.fromJson(Map<String, dynamic> json) {
    return ProgressList(
      progressList: (json['data'] as List<dynamic>?)
          ?.map((entry) => Progress.fromJson(entry as Map<String, dynamic>))
          .toList(),
    );
  }
}