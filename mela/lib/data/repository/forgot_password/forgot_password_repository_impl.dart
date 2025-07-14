import 'package:mela/data/network/apis/forgot_password/forgot_password_api.dart';
import 'package:mela/domain/repository/forgot_password/forgot_password_repository.dart';
import 'package:mela/domain/usecase/forgot_password/create_new_password_usecase.dart';
import 'package:mela/domain/usecase/forgot_password/verify_otp_usecase.dart';

class ForgotPasswordRepositoryImpl extends ForgotPasswordRepository {
  ForgotPasswordApi _forgotPasswordApi;
  ForgotPasswordRepositoryImpl(this._forgotPasswordApi);
  @override
  Future<void> verifyExistEmail(String email) async {
    return _forgotPasswordApi.verifyExistEmail(email);
  }

  @override
  Future<String> verifyOTP(OTPParams params) async {
    return _forgotPasswordApi.verifyOTP(params);
  }

  @override
  Future<void> createNewPassword(CreateNewPasswordParams params) async {
    return _forgotPasswordApi.createNewPassword(params);
  }
}
