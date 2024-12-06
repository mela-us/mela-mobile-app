import 'package:mobx/mobx.dart';

import '../../../core/stores/error/error_store.dart';
import '../../../domain/entity/stat/detailed_progress_list.dart';
import '../../../domain/entity/stat/progress_list.dart';
import '../../../utils/dio/dio_error_util.dart';

import '../../../domain/usecase/stat/get_progress_usecase.dart';
import '../../../domain/usecase/stat/get_detailed_progress_usecase.dart';

part 'stats_store.g.dart';

class StatisticsStore = _StatisticsStore with _$StatisticsStore;

abstract class _StatisticsStore with Store {
  //Constructor:----------------------------------------------------------------
  _StatisticsStore(
      this._getProgressListUseCase,
      this._getDetailedProgressListUseCase,
      this._errorStore
  );
  //UseCase:--------------------------------------------------------------------
  final GetProgressListUseCase _getProgressListUseCase;
  final GetDetailedProgressListUseCase _getDetailedProgressListUseCase;
  //Store:----------------------------------------------------------------------
  final ErrorStore _errorStore;

  // store variables:-----------------------------------------------------------
  //empty-------------
  static ObservableFuture<ProgressList?> emptyProgressListResponse =
  ObservableFuture.value(null);
  static ObservableFuture<DetailedProgressList?> emptyDetailedProgressListResponse =
  ObservableFuture.value(null);
  //fetch-------------
  @observable
  ObservableFuture<ProgressList?> fetchProgressFuture =
  ObservableFuture<ProgressList?>(emptyProgressListResponse);
  @observable
  ObservableFuture<DetailedProgressList?> fetchDetailedProgressFuture =
  ObservableFuture<DetailedProgressList?>(emptyDetailedProgressListResponse);
  //lists
  @observable
  ProgressList? progressList;
  @observable
  DetailedProgressList? detailedProgressList;
  //
  @observable
  bool success = false;
  //loading
  @computed
  bool get progressLoading => fetchProgressFuture.status == FutureStatus.pending;
  @computed
  bool get detailedProgressLoading => fetchDetailedProgressFuture.status == FutureStatus.pending;

  //action:---------------------------------------------------------------------
  @action
  Future getProgressList() async {
    final future = _getProgressListUseCase.call(params: null);
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
  Future getDetailedProgressList() async {
    final future = _getDetailedProgressListUseCase.call(params: null);
    fetchDetailedProgressFuture = ObservableFuture(future);

    future.then((list) {
      detailedProgressList = list;
    }).catchError((error) {
      _errorStore.errorMessage = DioExceptionUtil.handleError(error);
    });
  }
}
