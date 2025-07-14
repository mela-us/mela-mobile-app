import 'package:dio/dio.dart';
import 'package:mela/data/network/constants/endpoints_const.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/domain/usecase/forgot_password/create_new_password_usecase.dart';
import 'package:mela/domain/usecase/forgot_password/verify_otp_usecase.dart';

class ForgotPasswordApi {
  final DioClient _dioClient;
  ForgotPasswordApi(this._dioClient);
  Future<void> verifyExistEmail(String email) {
    return _dioClient.post(
      EndpointsConst.forgotPasswordSendEmail,
      options: Options(headers: {'Content-Type': 'application/json'}),
      data: {'username': email},
    );
  }

  Future<String> verifyOTP(OTPParams params) async {
    final response = await _dioClient.post(
      EndpointsConst.forgotPasswordVerifyOTP,
      options: Options(headers: {'Content-Type': 'application/json'}),
      data: {
        'username': params.email,
        'otpCode': params.otp,
      },
    );
    return response['token'];
  }

  Future<void> createNewPassword(CreateNewPasswordParams params) async {
    await _dioClient.post(
      EndpointsConst.forgotPasswordCreateNewPassword,
      options: Options(headers: {'Content-Type': 'application/json'}),
      data: params.toJson(),
    );
  }
}
