import 'package:mela/domain/entity/lecture/lecture.dart';

class LectureList {
  List<Lecture> lectures;
  LectureList({required this.lectures});
  factory LectureList.fromJson(List<dynamic> json) {
    List<Lecture> lectures = [];
    lectures = json.map((i) => Lecture.fromJson(i)).toList();
    return LectureList(lectures: lectures);
  }
}
