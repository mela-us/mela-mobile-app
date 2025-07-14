import 'package:mela/domain/usecase/forgot_password/verify_exist_email_usecase.dart';
import 'package:mela/utils/check_inputs/check_input.dart';
import 'package:mobx/mobx.dart';

part 'enter_email_store.g.dart';

// This is the class used by rest of your codebase
class EnterEmailStore = _EnterEmailStore with _$EnterEmailStore;

abstract class _EnterEmailStore with Store {
  // This for showing error message when user typing immediately
  @observable
  String email = ''; //use in when send verify otp

  @observable
  String emailError = '';

  @action
  void setEmail(String value) {
    email = value;
    emailError = CheckInput.validateEmail(value) ?? '';
  }

  //Usecase
  final VerifyExistEmailUseCase _verifyExistEmailUseCase;
  _EnterEmailStore(this._verifyExistEmailUseCase);

  //Observable
  @observable
  ObservableFuture<void> verifyEmailFuture =
      ObservableFuture(ObservableFuture.value(null));

  @computed
  bool get isLoadingVerifyEmail =>
      verifyEmailFuture.status == FutureStatus.pending;

  @action
  Future verifyEmail(String emailText) async {
    final future = _verifyExistEmailUseCase.call(params: emailText);
    verifyEmailFuture = ObservableFuture(future);

    try {
      await future;
      email = emailText;
    } catch (onError) {
      //error
      print("Vao enter email 5");
      throw "Email không tồn tại trong hệ thống";
    }
  }
    @action
  void reset() {
    email = '';
    emailError = '';
  }
}
