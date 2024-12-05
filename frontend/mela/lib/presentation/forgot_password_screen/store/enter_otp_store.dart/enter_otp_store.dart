import 'package:mela/di/service_locator.dart';
import 'package:mela/domain/usecase/forgot_password/verify_otp_usecase.dart';
import 'package:mela/presentation/forgot_password_screen/store/enter_email_store/enter_email_store.dart';
import 'package:mobx/mobx.dart';
import 'dart:async';

part 'enter_otp_store.g.dart';

class EnterOTPStore = _EnterOTPStore with _$EnterOTPStore;

abstract class _EnterOTPStore with Store {
  final VerifyOTPUseCase _verifyOTPUseCase;
  Timer? _timer;
  final _enterEmailStore = getIt<EnterEmailStore>();

  _EnterOTPStore(this._verifyOTPUseCase);

  String otp = '';
  String tokenResetPasswordFromSever = "";

  @observable
  int timeLeft = 10;

  @observable
  bool canResend = false;

  @observable
  ObservableFuture<void> verifyOTPFuture = ObservableFuture(Future.value());

  @computed
  bool get isLoading => verifyOTPFuture.status == FutureStatus.pending;

  void setOTP(String value) {
    otp = value;
  }

  @action
  void startTimer() {
    timeLeft = 10;
    canResend = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        timeLeft--;
      } else {
        canResend = true;
        timer.cancel();
      }
    });
  }

  @action
  Future<void> verifyOTP() async {
    final future =
        _verifyOTPUseCase.call(params: OTPParams(email: _enterEmailStore.email, otp: otp));
    verifyOTPFuture = ObservableFuture(future);
    try {
      tokenResetPasswordFromSever = await future;
    } catch (e) {
      throw e;
    }
  }

  @action
  Future<void> resendOTP() async {
    // Implement resend OTP logic
    _enterEmailStore.verifyEmail(_enterEmailStore.email);
    startTimer();
  }

  void disposeTimer() {
    _timer?.cancel();
  }
}
