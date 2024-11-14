import 'package:mela/domain/entity/exercise/exercise_list.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/entity/lecture/lecture.dart';
import '../../../domain/usecase/exercise/get_exercises_usecase.dart';
part 'exercise_store.g.dart';

class ExerciseStore = _ExerciseStore with _$ExerciseStore;

abstract class _ExerciseStore with Store {
  //usecase--------------
  GetExercisesUseCase _getExercisesUsecase;

  _ExerciseStore(this._getExercisesUsecase);

//obserbale
  @observable
  Lecture? currentLecture;

  @observable
  String errorString = '';

  @observable
  ExerciseList? exerciseList;

  @observable
  ObservableFuture<ExerciseList?> fetchExercisesFuture =
      ObservableFuture<ExerciseList?>(ObservableFuture.value(null));

  @computed
  bool get isGetExercisesLoading =>
      fetchExercisesFuture.status == FutureStatus.pending;

  @action
  Future getExercisesByLectureId() async {
    final future = _getExercisesUsecase.call(params: this.currentLecture!.lectureId);
    fetchExercisesFuture = ObservableFuture(future);
    await future.then((value) {
      this.exerciseList = value;
      this.errorString = '';
    }).catchError((onError) {
      print(onError);
      this.exerciseList = null;
      this.errorString = onError.toString();
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
