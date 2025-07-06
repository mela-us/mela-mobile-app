import 'package:mela/data/network/apis/lectures/lecture_api.dart';
import 'package:mela/domain/entity/divided_lecture/divided_lecture_list.dart';
import 'package:mela/domain/entity/lecture/lecture.dart';

import 'package:mela/domain/entity/lecture/lecture_list.dart';
import 'package:mela/domain/entity/suggestion/suggestion.dart';
import 'package:mela/domain/usecase/suggestion/update_suggestion_usecase.dart';

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
        ordinalNumber: 1,
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
  Future<DividedLectureList> getDividedLectureList(String lectureId) {
    return _lectureApi.getDividedLectures(lectureId);
  }

  // @override
  // Future<LectureList> getLecturesAreLearning() {
  //   return _lectureApi.getLecturesAreLearning();
  // }

  @override
  Future<ListSuggestion> getProposedNewSuggestion() {
    return _lectureApi.getProposedNewSuggestion();
  }

  @override
  Future<void> updateSuggestion(UpdateSuggestionParams params) {
    print("Sa3 ===> Updating suggestion in repository: ${params.suggestionId}, ${params.lectureId}, ${params.ordinalNumber}, ${params.isDone}");
    return _lectureApi.updateSuggestion(params);
  }
}
