import 'package:mela/domain/usecase/forgot_password/change_password_usecase.dart';
import 'package:mela/domain/usecase/forgot_password/verify_otp_usecase.dart';

abstract class ForgotPasswordRepository {
  Future<void> verifyExistEmail(String email);
  Future<String> verifyOTP(OTPParams params);
  Future<void> changePassword(ChangePasswordParams params);
}
