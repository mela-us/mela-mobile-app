import 'package:mela/domain/entity/lecture/lecture_list.dart';
import 'package:mela/domain/usecase/lecture/get_proposed_new_lecture_usecase.dart';
import 'package:mobx/mobx.dart';

part 'list_proposed_new_lecture_store.g.dart';

// This is the class used by rest of your codebase
class ListProposedNewLectureStore = _ListProposedNewLectureStore
    with _$ListProposedNewLectureStore;

abstract class _ListProposedNewLectureStore with Store {
  // UseCase
  final GetProposedNewLectureUsecase _getProposedNewLectureUsecase;
  _ListProposedNewLectureStore(this._getProposedNewLectureUsecase);
  @observable
  bool isLoading = false;

  @observable
  bool isUnAuthorized = false;

  @action
  void setLoading(bool value) {
    isLoading = value;
  }

  @action
  void setUnAuthorized(bool value) {
    isUnAuthorized = value;
  }

  @observable
  LectureList? lectureList;

  @action
  Future<void> getProposedNewLecture() async {
    setLoading(true);
    try {
      setLoading(true);
      // Simulate a network call
      lectureList = await _getProposedNewLectureUsecase.call();
    } catch (e) {
      lectureList = null;
      // Handle error
    } finally {
      setLoading(false);
    }
  }
}
