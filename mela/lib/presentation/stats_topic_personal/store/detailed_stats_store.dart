import 'package:mobx/mobx.dart';

import '../../../core/stores/error/error_store.dart';
import '../../../domain/entity/stat/detailed_stat_list.dart';
import '../../../domain/usecase/stat/get_detailed_progress_usecase.dart';
import '../../../utils/dio/dio_error_util.dart';

part 'detailed_stats_store.g.dart';

class DetailedStatStore = _DetailedStatStore with _$DetailedStatStore;

abstract class _DetailedStatStore with Store {
  //Constructor:----------------------------------------------------------------
  _DetailedStatStore(
      this._getDetailedStatsUseCase,
      this._errorStore,
      );
  //UseCase:--------------------------------------------------------------------
  final GetDetailedStatsUseCase _getDetailedStatsUseCase;
  //Store:----------------------------------------------------------------------
  final ErrorStore _errorStore;

  // store variables:-----------------------------------------------------------
  //empty-------------
  static ObservableFuture<DetailedStatList?> emptyListResponse =
  ObservableFuture.value(null);

  //fetch-------------
  @observable
  ObservableFuture<DetailedStatList?> fetchFuture =
  ObservableFuture<DetailedStatList?>(emptyListResponse);
  //lists
  @observable
  DetailedStatList? stats;
  //
  @observable
  bool success = false;

  //loading
  @computed
  bool get loading =>
      fetchFuture.status == FutureStatus.pending;

  //action:---------------------------------------------------------------------
  @action
  Future getStats() async {
    final future = _getDetailedStatsUseCase.call(params: null);
    fetchFuture = ObservableFuture(future);
    future.then((list) {
      stats = list;
      success = true;
    }).catchError((error) {
      _errorStore.errorMessage = DioExceptionUtil.handleError(error);
      success = false;
    });
  }
}
