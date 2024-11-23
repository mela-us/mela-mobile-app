import 'package:mela/domain/entity/lecture/lecture.dart';
import 'package:mela/domain/entity/lecture/lecture_list.dart';
import 'package:mela/domain/usecase/lecture/get_lectures_usecase.dart';

abstract class LectureRepository {
  Future<LectureList> getLectures(int topicId);
  Future<Lecture> getLectureById(int id);
  Future<LectureList> getLecturesAreLearning();
}