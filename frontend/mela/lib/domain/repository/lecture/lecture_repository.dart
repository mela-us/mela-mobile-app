import 'package:mela/domain/entity/divided_lecture/divided_lecture_list.dart';
import 'package:mela/domain/entity/lecture/lecture.dart';
import 'package:mela/domain/entity/lecture/lecture_list.dart';

abstract class LectureRepository {
  Future<LectureList> getLectures(String topicId);
  Future<Lecture> getLectureById(int id);
  Future<LectureList> getLecturesAreLearning();
  Future<LectureList> getProposedNewLecture();
  Future<DividedLectureList> getDividedLectureList(String lectureId);
}