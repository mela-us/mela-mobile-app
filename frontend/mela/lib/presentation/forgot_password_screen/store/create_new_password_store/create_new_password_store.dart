import 'package:mela/di/service_locator.dart';
import 'package:mela/domain/usecase/forgot_password/create_new_password_usecase.dart';
import 'package:mela/presentation/forgot_password_screen/store/enter_email_store/enter_email_store.dart';
import 'package:mela/presentation/forgot_password_screen/store/enter_otp_store.dart/enter_otp_store.dart';
import 'package:mela/utils/check_inputs/check_input.dart';
import 'package:mobx/mobx.dart';

part 'create_new_password_store.g.dart';

// This is the class used by rest of your codebase
class CreateNewPasswordStore = _CreateNewPasswordStore
    with _$CreateNewPasswordStore;

abstract class _CreateNewPasswordStore with Store {
  //Usecase
  final CreateNewPasswordUsecase _createNewPasswordUseCase;
  _CreateNewPasswordStore(this._createNewPasswordUseCase);

  //Store:
  final EnterEmailStore _enterEmailStore = getIt<EnterEmailStore>();
  final EnterOTPStore _enterOTPStore = getIt<EnterOTPStore>();

  //Observable
  @observable
  bool isPasswordVisible = false;

  @observable
  bool isConfirmedPasswordVisible = false;

  @observable
  ObservableFuture<void> changePasswordFuture =
      ObservableFuture(ObservableFuture.value(null));

  @computed
  bool get isLoadingChangePassword =>
      changePasswordFuture.status == FutureStatus.pending;
  @observable
  String passwordError = '';

  @observable
  String confirmedPasswordError = '';

  @action
  void setErrorPassword(String value) {
    passwordError = CheckInput.validatePassword(value) ?? '';
  }

  @action
  void setErrorConfirmedPassword(String password, String confirmedPassword) {
    confirmedPasswordError =
        CheckInput.validateConfirmedPassword(password, confirmedPassword) ?? '';
  }

  // actions:-------------------------------------------------------------------
  @action
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
  }

  // actions:-------------------------------------------------------------------
  @action
  void toggleConfirmedPasswordVisibility() {
    isConfirmedPasswordVisible = !isConfirmedPasswordVisible;
  }

  @action
  Future changePasswordInForgotPasswordScreen(String newPassword) async {
    final future = _createNewPasswordUseCase.call(
        params: CreateNewPasswordParams(
            username: _enterEmailStore.email,
            newPassword: newPassword,
            token: _enterOTPStore.tokenResetPasswordFromSever));
    changePasswordFuture = ObservableFuture(future);

    try {
      await future;
    } catch (onError) {
      //error
      throw "Thay đổi mật khẩu thất bại. Thử lại";
    }
  }
}
