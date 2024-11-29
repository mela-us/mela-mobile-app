import 'package:mela/data/network/apis/lectures/lecture_api.dart';
import 'package:mela/domain/entity/divided_lecture/divided_lecture_list.dart';
import 'package:mela/domain/entity/lecture/lecture.dart';

import 'package:mela/domain/entity/lecture/lecture_list.dart';
import 'package:mela/domain/entity/level/level_list.dart';

import '../../../domain/repository/lecture/lecture_repository.dart';

class LectureRepositoryImpl extends LectureRepository {
  final LectureApi _lectureApi;
  LectureRepositoryImpl(this._lectureApi);

  @override
  Future<Lecture> getLectureById(int id) async {
    await Future.delayed(Duration(seconds: 3));
    return Lecture(
        lectureId: "0",
        levelId: "0",
        topicId: "0",
        lectureName: "Lý thuyết đồng dư",
        lectureDescription: "Mô tả bài học chi tiết",
        totalExercises: 4,
        totalPassExercises: 2);
  }

  @override
  Future<LectureList> getLectures(String topicId) {
    //get all lecture in topic and level and filter in UI to show
    return _lectureApi.getLectures(topicId);
  }

  @override
  Future<LectureList> getLecturesAreLearning() async {
    return _lectureApi.getLecturesAreLearning();
  }

  @override
  Future<LevelList> getLevels() {
    return _lectureApi.getLevels();
  }

  @override
  Future<DividedLectureList> getDividedLectureList(String lectureId) {
    return _lectureApi.getDividedLectures(lectureId);
  }
}
