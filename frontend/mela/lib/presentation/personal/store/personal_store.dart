import 'package:mela/domain/entity/user/user.dart';
import 'package:mela/domain/usecase/user/get_user_info_usecase.dart';
import 'package:mobx/mobx.dart';

import '../../../core/stores/error/error_store.dart';
import '../../../domain/usecase/user/logout_usecase.dart';
import '../../../utils/dio/dio_error_util.dart';

part 'personal_store.g.dart';

class PersonalStore = _PersonalStore with _$PersonalStore;


abstract class _PersonalStore with Store {
  //Constructor:----------------------------------------------------------------
  _PersonalStore(
      this._getUserInfoUseCase,
      this._logoutUseCase,
      this._errorStore
      );
  //UseCase:--------------------------------------------------------------------
  final GetUserInfoUseCase _getUserInfoUseCase;
  final LogoutUseCase _logoutUseCase;
  //Store:----------------------------------------------------------------------
  final ErrorStore _errorStore;

  // store variables:-----------------------------------------------------------
  //empty-------------
  static ObservableFuture<User?> emptyResponse =
  ObservableFuture.value(null);
  //fetch-------------
  @observable
  ObservableFuture<User?> fetchFuture =
  ObservableFuture<User?>(emptyResponse);
  //
  @observable
  User? user;
  //
  @observable
  bool logout_success = false;
  //loading
  @computed
  bool get progressLoading => fetchFuture.status == FutureStatus.pending;
  @computed
  bool get detailedProgressLoading => fetchFuture.status == FutureStatus.pending;

  //action:---------------------------------------------------------------------
  @action
  Future getUserInfo() async {
    final future = _getUserInfoUseCase.call(params: null);
    fetchFuture = ObservableFuture(future);

    future.then((temp) {
      user = temp;
    }).catchError((error) {
      _errorStore.errorMessage = DioExceptionUtil.handleError(error);
    });
  }

  @action
  Future logout() async {
    final future = _logoutUseCase.call(params: null);
    future.then((temp) {
      logout_success = true;
    }).catchError((error) {
      _errorStore.errorMessage = DioExceptionUtil.handleError(error);
      logout_success = false;
    });
  }
}