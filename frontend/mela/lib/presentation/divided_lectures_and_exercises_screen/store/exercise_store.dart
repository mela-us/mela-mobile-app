import 'package:dio/dio.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/domain/entity/divided_lecture/divided_lecture_list.dart';
import 'package:mela/domain/entity/exercise/exercise_list.dart';
import 'package:mela/presentation/lectures_in_topic_screen/store/lecture_store.dart';
import 'package:mela/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/entity/lecture/lecture.dart';
import '../../../domain/usecase/exercise/get_exercises_usecase.dart';
part 'exercise_store.g.dart';

class ExerciseStore = _ExerciseStore with _$ExerciseStore;

abstract class _ExerciseStore with Store {
  LectureStore _lectureStore = getIt<LectureStore>();
  //usecase--------------
  GetExercisesUseCase _getExercisesUsecase;

  _ExerciseStore(this._getExercisesUsecase);

//obserbale
  @observable
  Lecture? currentLecture;

  @observable
  String errorString = '';

  @observable
  bool isUnAuthorized = false;

  @observable
  ExerciseList? exerciseList;

  @observable
  DividedLectureList? dividedLectureList;

  @observable
  ObservableFuture<ExerciseList?> fetchExercisesFuture =
      ObservableFuture<ExerciseList?>(ObservableFuture.value(null));

  @observable
  ObservableFuture<DividedLectureList?> fetchDividedLecturesFuture =
      ObservableFuture<DividedLectureList?>(ObservableFuture.value(null));

  @computed
  bool get isGetExercisesLoading =>
      fetchExercisesFuture.status == FutureStatus.pending ||
      fetchDividedLecturesFuture.status == FutureStatus.pending;

  @action
  Future getExercisesByLectureId() async {
    final future =
        _getExercisesUsecase.call(params: this.currentLecture!.lectureId);
    fetchExercisesFuture = ObservableFuture(future);
    //print("*********ABC");
    await future.then((value) {
      exerciseList = value;
      print("*********exerciseList trong exercise store");
      print(exerciseList);
    }).catchError((onError) {
      exerciseList = null;
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
  Future getDividedLecturesByLectureId() async {
    final future = _lectureStore.getDividedLectureUsecase
        .call(params: this.currentLecture!.lectureId);
    fetchDividedLecturesFuture = ObservableFuture(future);
    await future.then((value) {
      dividedLectureList = value;
      //print("*********dividedLectureList trong exercise store");
    }).catchError((onError) {
      dividedLectureList = null;
      if (onError is DioException) {
        if (onError.response?.statusCode == 401) {
          isUnAuthorized = true;
          return;
        }
        errorString = DioExceptionUtil.handleError(onError);
      } else {
        errorString = "Có lỗi, thử lại sau";
      }
      //errorString = onError.toString();
    });
  }

  @action
  void setCurrentLecture(Lecture mLecture) {
    // print("FlutterSa: Doi topic id trong setTopicId: $mtopicId");
    this.currentLecture = mLecture;
  }

  //Do when press back button
  // @action
  // void resetLectureId() {
  //   lectureId = -1;
  // }
  @action
  void resetErrorString() {
    errorString = '';
  }
}
