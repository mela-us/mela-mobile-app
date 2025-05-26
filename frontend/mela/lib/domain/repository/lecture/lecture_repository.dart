import 'package:mela/domain/entity/divided_lecture/divided_lecture_list.dart';
import 'package:mela/domain/entity/lecture/lecture.dart';
import 'package:mela/domain/entity/lecture/lecture_list.dart';
import 'package:mela/domain/entity/suggestion/suggestion.dart';
import 'package:mela/domain/usecase/suggestion/update_suggestion_usecase.dart';

abstract class LectureRepository {
  Future<LectureList> getLectures(String topicId);
  Future<Lecture> getLectureById(int id);
  Future<LectureList> getLecturesAreLearning();
  Future<ListSuggestion> getProposedNewSuggestion();
  Future<DividedLectureList> getDividedLectureList(String lectureId);
  Future<void> updateSuggestion(
    UpdateSuggestionParams params,
  );
}
