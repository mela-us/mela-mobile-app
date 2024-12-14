import 'package:dio/dio.dart';
import 'package:mela/domain/entity/user/token_model.dart';
import 'package:mela/domain/usecase/user_login/is_logged_in_usecase.dart';
import 'package:mela/domain/usecase/user_login/save_access_token_usecase.dart';
import 'package:mela/domain/usecase/user_login/save_login_in_status_usecase.dart';
import 'package:mela/domain/usecase/user_login/save_refresh_token_usecase.dart';
import 'package:mela/utils/dio/dio_error_util.dart';
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
  ) {
    // // setting up disposers
    // _setupDisposers();
    print("-----********|||||||||||| UserLoginStore");
    // checking if user is logged in share preference --> for myapp.dart
    _isLoggedInUseCase.call(params: null).then((value) async {
      isLoggedIn = value;
      print("-----******** is logged in in UserLoginStore $value");
    });
  }

  // use cases:-----------------------------------------------------------------
  final IsLoggedInUseCase _isLoggedInUseCase;
  final SaveLoginStatusUseCase _saveLoginStatusUseCase;
  final LoginUseCase _loginUseCase;
  final SaveAccessTokenUsecase _saveAccessTokenUsecase;
  final SaveRefreshTokenUsecase _saveRefreshTokenUsecase;

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
  @observable
  ObservableFuture<void> setIsLoginFuture = ObservableFuture.value(null);

  @computed
  bool get isLoading => loginFuture.status == FutureStatus.pending;

  @computed
  bool get isSetLoginLoading => setIsLoginFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
  }


  //use for refreshToken expired and set isLoggedIn=new value in share preferences
  @action
  Future setIsLogin() async {
    final future = _isLoggedInUseCase.call(params: null);

    setIsLoginFuture = ObservableFuture(future);

    await future.then((value) async {
      isLoggedIn = value;
      print("-----=========== is logged in in UserLoginStore $value");
    });
  }

  @action
  Future login(String email, String password) async {
    final LoginParams loginParams =
        LoginParams(username: email, password: password);
    final future = _loginUseCase.call(params: loginParams);
    loginFuture = ObservableFuture(future);
    // print("-----********* Email password");
    // print(email);
    // print(password);
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
      }
    }).catchError((e) {
      this.isLoggedIn = false;
      print("-----********* Error in UserLoginStore");
      print(e.toString());
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          throw "Mật khẩu hoặc tài khoản không hợp lệ";
        }
        throw DioExceptionUtil.handleError(e);
      } else {
        throw "Có lỗi, thử lại sau";
      }
    });
  }

  @action
  void resetSettingForLogin() {
    isPasswordVisible = false;
  }

  void logout() async {


    isLoggedIn = false;


    await _saveLoginStatusUseCase.call(params: false);
    await _saveAccessTokenUsecase.call(params: "");
    await _saveRefreshTokenUsecase.call(params: "");
  
  
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
