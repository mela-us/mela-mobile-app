import 'package:mela/domain/entity/lecture/lecture_list.dart';
import 'package:mela/domain/usecase/lecture/get_lectures_usecase.dart';
import 'package:mobx/mobx.dart';
part 'lecture_store.g.dart';

class LectureStore = _LectureStore with _$LectureStore;

abstract class _LectureStore with Store {
  //usecase--------------
  GetLecturesUsecase _getLecturesUsecase;

  _LectureStore(this._getLecturesUsecase);

//obserbale
  @observable
  int toppicId = -1;

  @observable
  String errorString = '';

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
    final future = _getLecturesUsecase.call(params: toppicId);
    fetchLectureFuture = ObservableFuture(future);
    await future.then((value) {
      this.lectureList = value;
      this.errorString = '';
    }).catchError((onError) {
      print(onError);
      this.lectureList = null;
      this.errorString = onError.toString();
    });
  }

  @action
  void setTopicId(int mtopicId) {
    // print("FlutterSa: Doi topic id trong setTopicId: $mtopicId");
    toppicId = mtopicId;
  }

  //Do when press back button
  @action
  void resetTopicId() {
    toppicId = -1;
  }

  //getLectureListByLevelId
  LectureList lecturesByLevelId = LectureList(lectures: []);
  LectureList getLectureListByLevelId(int levelId) {
    if (lectureList == null) {
      // print("FlutterSa: LectureList is null trong getLevelId");
      return lecturesByLevelId;
    }
    // print("FlutterSa: LectureList is Khong null trong getLevelId");
    lecturesByLevelId.lectures.clear();
    lecturesByLevelId.lectures = lectureList!.lectures
        .where((element) => element.levelId == levelId)
        .toList();
    // print(
    //     "*****LectureID trong getLecture by levelId sau khi da loc thanh cong****");
    // lecturesByLevelId!.lectures.forEach((element) {
    //   print("Lecture trong getLecture by levelId: ${element.lectureName}");
    // });
    return lecturesByLevelId;
  }

  @action
  void resetErrorString() {
    errorString = '';
  }
}
