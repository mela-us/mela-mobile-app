import 'package:mobx/mobx.dart';
part 'login_or_signup_store.g.dart';

class LoginOrSignupStore = _LoginOrSignupStore with _$LoginOrSignupStore;

abstract class _LoginOrSignupStore with Store {
  _LoginOrSignupStore();
  @observable
  bool isLoginScreen = true;

  @action
  void toggleChangeScreen() {
    isLoginScreen = !isLoginScreen;
    print("FlutterDemoInStore: ${isLoginScreen}");
  }
}
