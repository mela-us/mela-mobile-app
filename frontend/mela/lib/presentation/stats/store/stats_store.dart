import 'package:mobx/mobx.dart';

import '../../../core/stores/error/error_store.dart';
import '../../../domain/entity/level/level_list.dart';
import '../../../domain/entity/stat/progress_list.dart';
import '../../../domain/usecase/level/get_level_list_usecase.dart';
import '../../../utils/dio/dio_error_util.dart';

import '../../../domain/usecase/stat/get_progress_usecase.dart';

part 'stats_store.g.dart';

class StatisticsStore = _StatisticsStore with _$StatisticsStore;

abstract class _StatisticsStore with Store {
  //Constructor:----------------------------------------------------------------
  _StatisticsStore(
      this._getProgressListUseCase,
      this._getLevelListUsecase,
      this._errorStore,
  );
  //UseCase:--------------------------------------------------------------------
  final GetLevelListUsecase _getLevelListUsecase;
  final GetProgressListUseCase _getProgressListUseCase;
  //Store:----------------------------------------------------------------------
  final ErrorStore _errorStore;

  // store variables:-----------------------------------------------------------
  //empty-------------
  static ObservableFuture<ProgressList?> emptyProgressListResponse =
  ObservableFuture.value(null);

  //fetch-------------
  @observable
  ObservableFuture<ProgressList?> fetchProgressFuture =
  ObservableFuture<ProgressList?>(emptyProgressListResponse);
  @observable
  ObservableFuture<LevelList?> fetchLevelsFuture =
  ObservableFuture<LevelList?>(ObservableFuture.value(null));
  //lists
  @observable
  ProgressList? progressList;
  @observable
  LevelList? levelList;
  //
  @observable
  bool success = false;
  //loading
  @computed
  bool get progressLoading =>
      fetchProgressFuture.status == FutureStatus.pending
          || fetchLevelsFuture.status == FutureStatus.pending;

  //action:---------------------------------------------------------------------
  @action
  Future getProgressList(String level) async {
    final future = _getProgressListUseCase.call(params: level);
    fetchProgressFuture = ObservableFuture(future);
    future.then((list) {
      progressList = list;
      success = true;
    }).catchError((error) {
      _errorStore.errorMessage = DioExceptionUtil.handleError(error);
      success = false;
    });
  }
  @action
  Future getLevels() async {
    final future = _getLevelListUsecase.call(params: null);
    fetchLevelsFuture = ObservableFuture(future);
    await future.then((value) {
      levelList = value;
      success = true;
    }).catchError((error) {
      levelList = null;
      _errorStore.errorMessage = DioExceptionUtil.handleError(error);
      success = false;
    });
  }
}
