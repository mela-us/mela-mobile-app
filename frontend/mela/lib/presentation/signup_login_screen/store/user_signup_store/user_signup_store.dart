import 'package:dio/dio.dart';
import 'package:mela/utils/check_inputs/check_input.dart';
import 'package:mela/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';
import '../../../../domain/usecase/user_signup/signup_usecase.dart';

part 'user_signup_store.g.dart';

class UserSignupStore = _UserSignupStore with _$UserSignupStore;

abstract class _UserSignupStore with Store {
  //constructor
  _UserSignupStore(this._signupUseCase);

  //use cases
  final SignupUseCase _signupUseCase;

  //observables
  @observable
  bool isSignupSuccessful = false;

  @observable
  bool isPasswordVisible = false;

  @observable
  bool isAccepted = false;

  @observable
  ObservableFuture<void> signUpFuture = ObservableFuture.value(Future.value());

  @observable
  bool isSignupLoading = false;

  @action
  void setIsSignupLoading(bool value) {
    isSignupLoading = value;
  }

  //actions
  @action
  Future<void> signUp(String email, String password) async {
    // print("FlutterSa0: ${isSignupLoading}");
    SignupParams signupParams =
        SignupParams(username: email, password: password);
    final future = _signupUseCase.call(params: signupParams);
    signUpFuture = ObservableFuture(future);
    // print("FlutterSa1: ${isSignupLoading}");
    try {
      await future;
      // print("FlutterSa2: ${isSignupLoading}");
      isSignupSuccessful = true;
    } catch (e) {
      isSignupSuccessful = false;
      print("-----********* Error in UserSignupStore");
      print(e.toString());
      if (e is DioException) {
        if (e.response?.statusCode == 400) {
          throw "Tài khoản đã tồn tại";
        }
        throw DioExceptionUtil.handleError(e);
      } else {
        throw "Có lỗi. Thử lại sau";
      }
    }
  }

  // This for showing error message when user typing immediately
  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  String emailError = '';

  @observable
  String passwordError = '';

  @action
  void setEmail(String value) {
    email = value;
    emailError = CheckInput.validateEmail(value) ?? '';
  }

  @action
  void setPassword(String value) {
    password = value;
    passwordError = CheckInput.validatePassword(value) ?? '';
  }

  @action
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
  }

  @action
  void toggleAccepted() {
    isAccepted = !isAccepted;
  }

  //If user signup -> signin -> singnup isSignupSuccessful will set false, so we can signup again with other email
  //if not set  to false again, user enter signup it still observe isSignupSuccessful as true and not change to login screen
  @action
  void resetSettingForSignnup() {
    isAccepted = false;
    isPasswordVisible = false;
    isSignupSuccessful = false;
    email = '';
    password = '';
    emailError = '';
    passwordError = '';
  }
}
