import 'package:dio/dio.dart';
import 'package:mela/domain/entity/level/level.dart';
import 'package:mela/domain/entity/topic_lecture_in_level/topic_lecture_in_level_list.dart';
import 'package:mela/domain/usecase/topic_lecture/get_topic_lecture_usecase.dart';
import 'package:mela/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

part 'topic_lecture_store.g.dart';

class TopicLectureStore = _TopicLectureStore with _$TopicLectureStore;

abstract class _TopicLectureStore with Store {
  //usecase--------------
  GetTopicLectureUsecase _getTopicLectureUsecase; //use in topicstore

  _TopicLectureStore(this._getTopicLectureUsecase);

//obserbale
  @observable
  Level? currentLevel;

  @observable
  String errorString = '';

  @observable
  bool isUnAuthorized = false;

  @observable
  TopicLectureInLevelList?
      topicLectureInLevelList; // all topic + all lecture in topic with current level

  @computed
  bool get isGetTopicLectureLoading =>
      fetchTopicLectureFuture.status == FutureStatus.pending;

  @observable
  ObservableFuture<TopicLectureInLevelList?> fetchTopicLectureFuture =
      ObservableFuture<TopicLectureInLevelList?>(ObservableFuture.value(null));

  //action
  @action
  Future getListTopicLectureInLevel() async {
    final future = _getTopicLectureUsecase.call(params: currentLevel!.levelId);
    fetchTopicLectureFuture = ObservableFuture(future);
    await future.then((value) {
      topicLectureInLevelList = value;
      print("FlutterSa: topicLectureInLevelList: $topicLectureInLevelList");
      for (var topic in topicLectureInLevelList!.topicLectureInLevelList) {
        print("FlutterSa: topicName: ${topic.topicName}");
        for (var lecture in topic.lectureList.lectures) {
          print("FlutterSa: lectureName: ${lecture.lectureName}");
        }
      }
    }).catchError((onError) {
      topicLectureInLevelList = null;
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
  void setCurrentLevel(Level mCurrentLevel) {
    // print("FlutterSa: Doi topic id trong setTopicId: $mtopicId");
    currentLevel = mCurrentLevel;
  }

  //Do when press back button
  @action
  void resetTopic() {
    currentLevel = null;
  }

  //getLectureListByLevelId
  // LectureList lecturesByLevelId = LectureList(lectures: []);
  // LectureList getLectureListByLevelId(String levelId) {
  //   if (lectureList == null) {
  //     return lecturesByLevelId;
  //   }
  //   lecturesByLevelId.lectures.clear();
  //   lecturesByLevelId.lectures = lectureList!.lectures
  //       .where((element) => element.levelId == levelId)
  //       .toList();
  //   return lecturesByLevelId;
  // }

  @action
  void resetErrorString() {
    errorString = '';
  }

  //Untils--------------------------------------------------------------
  // String getTopicIdInLectures(String lectureId) {
  //   if (lectureList == null) return "";

  //   for (var lecture in lectureList!.lectures) {
  //     if (lecture.lectureId == lectureId) {
  //       return lecture.topicId;
  //     }
  //   }

  //   return "";
  // }

  // String getLectureNameByIdInLectures(String lectureId) {
  //   if (lectureList == null) return "";

  //   for (var lecture in lectureList!.lectures) {
  //     if (lecture.lectureId == lectureId) {
  //       return lecture.lectureName;
  //     }
  //   }

  //   return "";
  // }

  // String getLevelIdByLectureIdInLectures(String lectureId) {
  //   if (lectureList == null) return "";

  //   for (var lecture in lectureList!.lectures) {
  //     if (lecture.lectureId == lectureId) {
  //       return lecture.levelId;
  //     }
  //   }

  //   return "";
  // }
}
