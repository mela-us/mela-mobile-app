import 'package:mela/domain/entity/user_data/user.dart';
import 'package:mela/domain/usecase/user/get_user_info_usecase.dart';
import 'package:mobx/mobx.dart';

import '../../../core/stores/error/error_store.dart';
import '../../../utils/dio/dio_error_util.dart';

part 'personal_store.g.dart';

class PersonalStore = _PersonalStore with _$PersonalStore;


abstract class _PersonalStore with Store {
  //Constructor:----------------------------------------------------------------
  _PersonalStore(
      this._getUserInfoUseCase,
      this._errorStore
      );
  //UseCase:--------------------------------------------------------------------
  final GetUserInfoUseCase _getUserInfoUseCase;
  //Store:----------------------------------------------------------------------
  final ErrorStore _errorStore;

  // store variables:-----------------------------------------------------------
  //empty-------------
  static ObservableFuture<UserData?> emptyResponse =
  ObservableFuture.value(null);
  //fetch-------------
  @observable
  ObservableFuture<UserData?> fetchFuture =
  ObservableFuture<UserData?>(emptyResponse);
  //
  @observable
  UserData? user;
  //
  @observable
  bool success = false;
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
}