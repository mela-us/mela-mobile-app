import 'package:dio/dio.dart';
import 'package:mela/domain/entity/lecture/lecture_list.dart';
import 'package:mela/domain/entity/level/level_list.dart';
import 'package:mela/domain/entity/topic/topic_list.dart';
import 'package:mela/domain/usecase/lecture/get_lectures_are_learning_usecase.dart';
import 'package:mela/domain/usecase/level/get_level_list_usecase.dart';
import 'package:mela/domain/usecase/topic/get_topics_usecase.dart';
import 'package:mobx/mobx.dart';

import '../../../../utils/dio/dio_error_util.dart';
// Include generated file
part 'level_store.g.dart';

// This is the class used by rest of your codebase
class LevelStore = _LevelStore with _$LevelStore;

abstract class _LevelStore with Store {
  //UseCase
  GetLevelListUsecase _getLevelListUsecase;
  // GetLecturesAreLearningUsecase _getLecturesAreLearningUsecase;
  GetTopicsUsecase _getTopicsUsecase;

  @observable
  TopicList? topicList;

  @observable
  LectureList? lecturesAreLearningList;

  @observable
  LevelList? levelList;

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
  _LevelStore(this._getLevelListUsecase, this._getTopicsUsecase);

  @observable
  ObservableFuture<LectureList?> fetchLecturesAreLearningFuture =
      ObservableFuture<LectureList?>(ObservableFuture.value(null));

  @observable
  ObservableFuture<LevelList?> fetchLevelsFuture =
      ObservableFuture<LevelList?>(ObservableFuture.value(null));

  @observable
  ObservableFuture<TopicList?> fetchTopicsFuture =
      ObservableFuture<TopicList?>(ObservableFuture.value(null));

  //Actions: -----------------------------------------------------------------------------------------------------------
  // @action
  // Future getAreLearningLectures() async {
  //   final future = _getLecturesAreLearningUsecase.call(params: null);
  //   fetchLecturesAreLearningFuture = ObservableFuture(future);
  //   try {
  //     lecturesAreLearningList = await future;
  //     //this.errorString = '';
  //   } catch (onError) {
  //     lecturesAreLearningList = null;
  //     if (onError is DioException) {
  //       if (onError.response?.statusCode == 401) {
  //         isUnAuthorized = true;
  //         return;
  //       }
  //       errorString = DioExceptionUtil.handleError(onError);
  //     } else {
  //       errorString = "Có lỗi, thử lại sau";
  //     }
  //   }
  // }

  @action
  Future getLevels() async {
    final future = _getLevelListUsecase.call(params: null);
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
  void resetErrorString() {
    errorString = '';
  }

  //Untils--------------------------------------------------------------
  String getLevelNameById(String levelId) {
    if (levelList == null) return "Null";
    // print("----------12345--------------$levelId");
    // for (var level in levelList!.levelList) {
    //   print("level.levelId: ${level.levelId} voi name ${level.levelName}");
    // }
    for (var level in levelList!.levelList) {
      if (level.levelId == levelId) {
        return level.levelName;
      }
    }

    return "Default";
  }

  String getTopicNameById(String topicId) {
    if (topicList == null) return "Null";

    for (var topic in topicList!.topics) {
      if (topic.topicId == topicId) {
        return topic.topicName;
      }
    }

    return "Default";
  }
}
