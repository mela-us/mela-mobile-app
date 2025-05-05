
import 'package:mela/domain/entity/streak/streak.dart';
import 'package:mobx/mobx.dart';

import '../../../core/stores/error/error_store.dart';

import '../../../domain/usecase/streak/get_streak_usecase.dart';
import '../../../domain/usecase/streak/update_streak_usecase.dart';
import '../../../utils/dio/dio_error_util.dart';

part 'streak_store.g.dart';

class StreakStore = _StreakStore with _$StreakStore;


abstract class _StreakStore with Store {
  //Constructor:----------------------------------------------------------------
  _StreakStore(this._errorStore, this._getStreakUseCase, this._updateStreakUseCase);

  //UseCase:--------------------------------------------------------------------
  final GetStreakUseCase _getStreakUseCase;
  final UpdateStreakUseCase _updateStreakUseCase;

  //Store:----------------------------------------------------------------------
  final ErrorStore _errorStore;

  // store variables:-----------------------------------------------------------
  //empty-------------
  static ObservableFuture<Streak?> emptyResponse =
  ObservableFuture.value(null);

  //fetch-------------
  @observable
  ObservableFuture<Streak?> fetchFuture =
  ObservableFuture<Streak?>(emptyResponse);

  @observable
  ObservableFuture<bool?> updateFuture = ObservableFuture.value(null);

  //
  @observable
  Streak? streak;

  @observable
  bool? updateSuccess;

  @observable
  bool isLoading = false;

  //loading
  @computed
  bool get streakLoading => fetchFuture.status == FutureStatus.pending;

  //action:---------------------------------------------------------------------
  @action
  Future getStreak() async {
    isLoading = true;
    final future = _getStreakUseCase.call(params: null);
    fetchFuture = ObservableFuture(future);

    future.then((temp) {
      streak = temp;
    }).catchError((error) {
      _errorStore.errorMessage = DioExceptionUtil.handleError(error);
    });

    isLoading = false;
  }

  @action
  Future updateStreak() async {
    final future = _updateStreakUseCase.call(params: null);
    updateFuture = ObservableFuture(future);

    future.then((temp) {
      updateSuccess = temp;
    }).catchError((error) {
      _errorStore.errorMessage = DioExceptionUtil.handleError(error);
    });
  }
}