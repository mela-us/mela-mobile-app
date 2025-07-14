import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/repository/forgot_password/forgot_password_repository.dart';

class OTPParams {
  final String email;
  final String otp;

  OTPParams({required this.email, required this.otp});
}

class VerifyOTPUseCase extends UseCase<String, OTPParams> {
  final ForgotPasswordRepository _forgotPasswordRepository;
  VerifyOTPUseCase(this._forgotPasswordRepository);
  @override
  Future<String> call({required OTPParams params}) {
    return _forgotPasswordRepository.verifyOTP(params);
  }
}
