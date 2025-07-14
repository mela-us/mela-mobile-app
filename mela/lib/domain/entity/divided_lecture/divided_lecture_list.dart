import 'package:mela/domain/entity/divided_lecture/divided_lecture.dart';

class DividedLectureList {
  final List<DividedLecture> dividedLectures;
  DividedLectureList({required this.dividedLectures});
  factory DividedLectureList.fromJson(List<dynamic> json) {
    return DividedLectureList(
        dividedLectures: json
            .map((e) => DividedLecture.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}