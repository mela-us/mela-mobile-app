import 'package:mela/domain/usecase/user_login/is_logged_in_usecase.dart';
import 'package:mela/domain/usecase/user_login/save_login_in_status_usecase.dart';
import 'package:mobx/mobx.dart';

import '../../../../domain/entity/user/user.dart';
import '../../../../domain/usecase/user_login/login_usecase.dart';

part 'user_login_store.g.dart';

class UserLoginStore = _UserLoginStore with _$UserLoginStore;

abstract class _UserLoginStore with Store {
  // constructor:---------------------------------------------------------------
  _UserLoginStore(
    this._isLoggedInUseCase,
    this._saveLoginStatusUseCase,
    this._loginUseCase,
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


  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  // void _setupDisposers() {
  //   _disposers = [
  //     reaction((_) => success, (_) => success = false, delay: 200),
  //   ];
  // }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<User?> emptyLoginResponse =
      ObservableFuture.value(null);

  // store variables:-----------------------------------------------------------
  @observable
  bool isLoggedIn = false;

  // @observable
  // bool success = false;

  @observable
  bool isPasswordVisible = false;

  @observable
  ObservableFuture<User?> loginFuture = emptyLoginResponse;

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
    print("FlutterSa: loginFuture: ${isLoggedIn ? "true" : "false"}");
    await future.then((value) async {
      if (value != null) {
        await _saveLoginStatusUseCase.call(params: true);
        this.isLoggedIn = true;
        print("FlutterSa: After future reture: ${isLoggedIn ? "true" : "false"}");
        // this.success = true;
      }
    }).catchError((e) {
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
