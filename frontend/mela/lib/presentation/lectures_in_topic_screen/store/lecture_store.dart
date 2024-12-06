import 'package:dio/dio.dart';
import 'package:mela/domain/entity/lecture/lecture_list.dart';
import 'package:mela/domain/usecase/lecture/get_divided_lecture_usecase.dart';
import 'package:mela/domain/usecase/lecture/get_lectures_are_learning_usecase.dart';
import 'package:mela/domain/usecase/lecture/get_lectures_usecase.dart';
import 'package:mela/domain/usecase/lecture/get_levels_usecase.dart';
import 'package:mela/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/entity/topic/topic.dart';
part 'lecture_store.g.dart';

class LectureStore = _LectureStore with _$LectureStore;

abstract class _LectureStore with Store {
  //usecase--------------
  GetLecturesUsecase _getLecturesUsecase;
  GetLecturesAreLearningUsecase getLecturesAreLearningUsecase;
  GetDividedLectureUsecase getDividedLectureUsecase; //use in topicstore

  GetLevelsUsecase getLevelsUsecase;
  _LectureStore(this._getLecturesUsecase, this.getLecturesAreLearningUsecase,
      this.getLevelsUsecase, this.getDividedLectureUsecase);

//obserbale
  @observable
  Topic? currentTopic;

  @observable
  String errorString = '';

  @observable
  bool isUnAuthorized = false;

  @observable
  LectureList?
      lectureList; //Lecture in Topic, not Lecture in Topic + level to improve performance
  //mean get All lecture after filter in getLectureListByLevelId

  @computed
  bool get isGetLecturesLoading =>
      fetchLectureFuture.status == FutureStatus.pending;

  @observable
  ObservableFuture<LectureList?> fetchLectureFuture =
      ObservableFuture<LectureList?>(ObservableFuture.value(null));

  //action
  @action
  Future getListLectureByTopicIdAndLevelId() async {
    final future = _getLecturesUsecase.call(params: currentTopic!.topicId);
    fetchLectureFuture = ObservableFuture(future);
    await future.then((value) {
      lectureList = value;
    }).catchError((onError) {
      lectureList = null;
      if (onError is DioException) {
        if (onError.response?.statusCode == 401) {
          isUnAuthorized = true;
          return;
        }
        errorString = DioExceptionUtil.handleError(onError);
      } else {
        errorString = "Có lỗi, thử lại sau";
      }
    });
  }

  @action
  void setCurrentTopic(Topic mCurrentTopic) {
    // print("FlutterSa: Doi topic id trong setTopicId: $mtopicId");
    currentTopic = mCurrentTopic;
  }

  //Do when press back button
  @action
  void resetTopic() {
    currentTopic = null;
  }

  //getLectureListByLevelId
  LectureList lecturesByLevelId = LectureList(lectures: []);
  LectureList getLectureListByLevelId(String levelId) {
    if (lectureList == null) {
      return lecturesByLevelId;
    }
    lecturesByLevelId.lectures.clear();
    lecturesByLevelId.lectures = lectureList!.lectures
        .where((element) => element.levelId == levelId)
        .toList();
    return lecturesByLevelId;
  }

  @action
  void resetErrorString() {
    errorString = '';
  }

  //Untils--------------------------------------------------------------
  String getTopicIdInLectures(String lectureId) {
    if (lectureList == null) return "";

    for (var lecture in lectureList!.lectures) {
      if (lecture.lectureId == lectureId) {
        return lecture.topicId;
      }
    }

    return "";
  }

  String getLectureNameByIdInLectures(String lectureId) {
    if (lectureList == null) return "";

    for (var lecture in lectureList!.lectures) {
      if (lecture.lectureId == lectureId) {
        return lecture.lectureName;
      }
    }

    return "";
  }

  String getLevelIdByLectureIdInLectures(String lectureId) {
    if (lectureList == null) return "";

    for (var lecture in lectureList!.lectures) {
      if (lecture.lectureId == lectureId) {
        return lecture.levelId;
      }
    }

    return "";
  }
}
