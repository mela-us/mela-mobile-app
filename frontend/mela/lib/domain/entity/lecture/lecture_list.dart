import 'package:mela/domain/entity/lecture/lecture.dart';

class LectureList {
  List<Lecture> lectures;
  LectureList({required this.lectures});
  factory LectureList.fromJson(List<dynamic> json) {
    List<Lecture> list = <Lecture>[];
    list = json.map((lecture) => Lecture.fromJson(lecture)).toList();
    return LectureList(
      lectures: list,
    );
  }
}
