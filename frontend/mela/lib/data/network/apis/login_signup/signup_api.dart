import 'package:dio/dio.dart';
import 'package:mela/core/extensions/response_status.dart';
import 'package:mela/data/network/constants/endpoints_const.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/domain/entity/user/token_model.dart';
import 'package:mela/domain/usecase/user_login/login_usecase.dart';
import 'package:mela/domain/usecase/user_signup/signup_usecase.dart';

class SignupApi {
  final DioClient _dioClient;
  SignupApi(this._dioClient);
  Future<void> signup(SignupParams signupParams) async {
    try {
      final responseData = await _dioClient.post(
        EndpointsConst.signup,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: signupParams.toJson(),
      );
      if (responseData['status'] == 'BAD_REQUEST') {
        throw ResponseStatus.BAD_REQUEST;
      }
    } catch (e) {
      rethrow;
    }
  }
}
