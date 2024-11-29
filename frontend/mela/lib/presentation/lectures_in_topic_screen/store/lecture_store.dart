import 'package:dio/dio.dart';
import 'package:mela/core/extensions/response_status.dart';
import 'package:mela/domain/entity/lecture/lecture_list.dart';
import 'package:mela/domain/entity/level/level_list.dart';
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
  GetLecturesAreLearningUsecase
      getLecturesAreLearningUsecase; //use in topicstore
  GetLevelsUsecase _getLevelsUsecase;
  _LectureStore(this._getLecturesUsecase, this.getLecturesAreLearningUsecase,
      this._getLevelsUsecase);

//obserbale
  @observable
  Topic? currentTopic;

  @observable
  String errorString = '';

  @observable
  bool isUnAuthorized = false;

  @observable
  LevelList? levelList;

  @observable
  LectureList?
      lectureList; //Lecture in Topic, not Lecture in Topic + level to improve performance
  //mean get All lecture after filter in getLectureListByLevelId

  @computed
  bool get isGetLecturesLoading =>
      fetchLectureFuture.status == FutureStatus.pending ||
      fetchLevelsFuture.status == FutureStatus.pending;

  @observable
  ObservableFuture<LectureList?> fetchLectureFuture =
      ObservableFuture<LectureList?>(ObservableFuture.value(null));

  @observable
  ObservableFuture<LevelList?> fetchLevelsFuture =
      ObservableFuture<LevelList?>(ObservableFuture.value(null));

  //action
  @action
  Future getListLectureByTopicIdAndLevelId() async {
    final future = _getLecturesUsecase.call(params: currentTopic!.topicId);
    fetchLectureFuture = ObservableFuture(future);
    await future.then((value) {
      lectureList = value;
    }).catchError((onError) {
      if (onError is DioException) {
        errorString = DioExceptionUtil.handleError(onError);
        lectureList = null;
      } else {
        lectureList = null;
        if (onError == ResponseStatus.UNAUTHORIZED) {
          isUnAuthorized = true;
        }
      }
    });
  }

  @action
  Future getLevels() async {
    final future = _getLevelsUsecase.call(params: null);
    fetchLevelsFuture = ObservableFuture(future);
    await future.then((value) {
      levelList = value;
    }).catchError((onError) {
      if (onError is DioException) {
        errorString = DioExceptionUtil.handleError(onError);
      } else {
        errorString = onError.toString();
      }
      levelList = null;
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
}
