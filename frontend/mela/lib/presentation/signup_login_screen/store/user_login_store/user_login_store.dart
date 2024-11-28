import 'package:dio/dio.dart';
import 'package:mela/core/stores/error/error_store.dart';
import 'package:mela/domain/entity/user/token_model.dart';
import 'package:mela/domain/entity/user/user.dart';
import 'package:mela/domain/usecase/user_login/is_logged_in_usecase.dart';
import 'package:mela/domain/usecase/user_login/save_access_token_usecase.dart';
import 'package:mela/domain/usecase/user_login/save_login_in_status_usecase.dart';
import 'package:mela/domain/usecase/user_login/save_refresh_token_usecase.dart';
import 'package:mobx/mobx.dart';

import '../../../../domain/usecase/user_login/login_usecase.dart';

part 'user_login_store.g.dart';

class UserLoginStore = _UserLoginStore with _$UserLoginStore;

abstract class _UserLoginStore with Store {
  // constructor:---------------------------------------------------------------
  _UserLoginStore(
    this._isLoggedInUseCase,
    this._saveLoginStatusUseCase,
    this._loginUseCase,
    this._saveAccessTokenUsecase,
    this._saveRefreshTokenUsecase,
    this.errorStore,
  ) {
    // // setting up disposers
    // _setupDisposers();

    // checking if user is logged in share preference
    _isLoggedInUseCase.call(params: null).then((value) async {
      isLoggedIn = value;
    });
  }

  // use cases:-----------------------------------------------------------------
  final IsLoggedInUseCase _isLoggedInUseCase;
  final SaveLoginStatusUseCase _saveLoginStatusUseCase;
  final LoginUseCase _loginUseCase;
  final SaveAccessTokenUsecase _saveAccessTokenUsecase;
  final SaveRefreshTokenUsecase _saveRefreshTokenUsecase;
  final ErrorStore errorStore;

  //Error
  


  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  // void _setupDisposers() {
  //   _disposers = [
  //     reaction((_) => success, (_) => success = false, delay: 200),
  //   ];
  // }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<TokenModel?> emptyLoginResponse =
      ObservableFuture.value(null);

  // store variables:-----------------------------------------------------------
  @observable
  bool isLoggedIn = false;

  // @observable
  // bool success = false;

  @observable
  bool isPasswordVisible = false;

  @observable
  ObservableFuture<TokenModel?> loginFuture = emptyLoginResponse;

  @computed
  bool get isLoading => loginFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
  }
  @action
  Future login(String email, String password) async {
    final LoginParams loginParams =
        LoginParams(username: email, password: password);
    final future = _loginUseCase.call(params: loginParams);
    loginFuture = ObservableFuture(future);
    print("-----********* Email password");
    print(email);
    print(password);
    //print("FlutterSa: loginFuture: ${isLoggedIn ? "true" : "false"}");
    await future.then((value) async {
      if (value != null) {
        await _saveLoginStatusUseCase.call(params: true);
        await _saveAccessTokenUsecase.call(params: value.accessToken);
        await _saveRefreshTokenUsecase.call(params: value.refreshToken);
        print("-----********* Sau khi login thanh cong in UserLoginStore");
        print(value.accessToken);
        print(value.refreshToken);
        this.isLoggedIn = true;
        //print("FlutterSa: After future reture: ${isLoggedIn ? "true" : "false"}");
        // this.success = true;
      }
    }).catchError((e) {
      print("-----********* Error in UserLoginStore");
      if(e is DioException){
        print(e);  
        print(e.message);
        print(e.response?.data);
        print(e.response?.statusCode);
        //errorStore.errorMessage = e.toString();
      }
      print(e);
      this.isLoggedIn = false;
      // this.success = false;
      throw e;
    });
  }
  @action
  void resetSettingForLogin(){
    isPasswordVisible = false;
  }

  logout() async {
    this.isLoggedIn = false;
    await _saveLoginStatusUseCase.call(params: false);
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
