import 'package:dio/dio.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/domain/entity/lecture/lecture_list.dart';
import 'package:mela/domain/entity/level/level_list.dart';
import 'package:mela/domain/entity/topic/topic.dart';
import 'package:mela/domain/entity/topic/topic_list.dart';
import 'package:mela/presentation/lectures_in_topic_screen/store/lecture_store.dart';
import 'package:mobx/mobx.dart';

import '../../../../di/service_locator.dart';
import '../../../../domain/usecase/topic/get_topics_usecase.dart';
import '../../../../utils/dio/dio_error_util.dart';
// Include generated file
part 'topic_store.g.dart';

// This is the class used by rest of your codebase
class TopicStore = _TopicStore with _$TopicStore;

abstract class _TopicStore with Store {
  final GetTopicsUsecase _getTopicsUsecase;

  @observable
  TopicList? topicList;

  @observable
  LectureList? lecturesAreLearningList;

  @observable
  LevelList? levelList;

  LectureStore _lectureStore = getIt<LectureStore>();

  @observable
  String errorString = ''; //for dioException

  @observable
  bool isUnAuthorized =
      false; //for call api failed with refresh token expired -> login again

  @computed
  bool get loading =>
      fetchTopicsFuture.status == FutureStatus.pending ||
      fetchLecturesAreLearningFuture.status == FutureStatus.pending ||
      fetchLevelsFuture.status == FutureStatus.pending;

  //Constructor
  _TopicStore(this._getTopicsUsecase);

  @observable
  ObservableFuture<TopicList?> fetchTopicsFuture =
      ObservableFuture<TopicList?>(ObservableFuture.value(null));

  @observable
  ObservableFuture<LectureList?> fetchLecturesAreLearningFuture =
      ObservableFuture<LectureList?>(ObservableFuture.value(null));

  @observable
  ObservableFuture<LevelList?> fetchLevelsFuture =
      ObservableFuture<LevelList?>(ObservableFuture.value(null));

  @action
  Future getTopics() async {
    final future = _getTopicsUsecase.call(params: null);
    fetchTopicsFuture = ObservableFuture(future);

    try {
      //print("Vao get topic in topic store");
      topicList = await future;
      print(topicList);
      //this.errorString = '';
    } catch (onError) {
      topicList = null;
      if (onError is DioException) {
        if (onError.response?.statusCode == 401) {
          isUnAuthorized = true;
          return;
        }
        errorString = DioExceptionUtil.handleError(onError);
      } else {
        errorString = "Có lỗi, thử lại sau";
      }
    }
  }

  @action
  Future getAreLearningLectures() async {
    final future =
        _lectureStore.getLecturesAreLearningUsecase.call(params: null);
    fetchLecturesAreLearningFuture = ObservableFuture(future);
    try {
      lecturesAreLearningList = await future;
      //this.errorString = '';
    } catch (onError) {
      lecturesAreLearningList = null;
      if (onError is DioException) {
        if (onError.response?.statusCode == 401) {
          isUnAuthorized = true;
          return;
        }
        errorString = DioExceptionUtil.handleError(onError);
      } else {
        errorString = "Có lỗi, thử lại sau";
      }
    }
  }

  @action
  Future getLevels() async {
    final future = _lectureStore.getLevelsUsecase.call(params: null);
    fetchLevelsFuture = ObservableFuture(future);
    await future.then((value) {
      levelList = value;
    }).catchError((onError) {
      levelList = null;
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
  void resetErrorString() {
    errorString = '';
  }

  //Untils--------------------------------------------------------------
  //Use in exercise
  String getTopicIdInAreLearningLectures(String lectureId) {
    if (lecturesAreLearningList == null) return "";

    for (var lecture in lecturesAreLearningList!.lectures) {
      if (lecture.lectureId == lectureId) {
        return lecture.topicId;
      }
    }

    return "";
  }

  String getLevelIdByLectureIdInAreLearningLectures(String lectureId) {
    if (lecturesAreLearningList == null) return "";

    for (var lecture in lecturesAreLearningList!.lectures) {
      if (lecture.lectureId == lectureId) {
        return lecture.levelId;
      }
    }

    return "";
  }

  String getTopicNameByIdInTopicStore(String topicId) {
    if (topicList == null) return "";
    for (Topic topic in topicList!.topics) {
      if (topic.topicId == topicId) {
        return topic.topicName;
      }
    }
    return "";
  }

  String getLevelNameInTopicStore(String levelId) {
    if (levelList == null) return "";

    for (var level in levelList!.levelList) {
      if (level.levelId == levelId) {
        return level.levelName;
      }
    }
    return "";
  }
}
