import 'package:dio/dio.dart';
import 'package:mela/domain/entity/level/level_list.dart';
import 'package:mela/domain/usecase/level/get_level_list_usecase.dart';
import 'package:mela/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

part 'tutor_store.g.dart';

class TutorStore = _TutorStore with _$TutorStore;

abstract class _TutorStore with Store {
  GetLevelListUsecase _getLevelListUsecase;

  @observable
  ObservableFuture<LevelList?> fetchLevelsFuture =
      ObservableFuture<LevelList?>(ObservableFuture.value(null));

  @computed
  bool get loading => fetchLevelsFuture.status == FutureStatus.pending;

  _TutorStore(this._getLevelListUsecase);

  @observable
  bool isUnAuthorized = false;

  @observable
  String errorString = ''; //for dioException

  @observable
  LevelList? levelList;
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
  void resetErrorString() {
    errorString = '';
  }

  String getLevelNameById(String levelId) {
    if (levelList == null) return "Null";
    for (var level in levelList!.levelList) {
      if (level.levelId == levelId) {
        return level.levelName;
      }
    }

    return "Default";
  }
}
