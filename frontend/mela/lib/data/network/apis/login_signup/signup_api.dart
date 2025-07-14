import 'package:dio/dio.dart';
import 'package:mela/data/network/constants/endpoints_const.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/domain/usecase/user_signup/signup_usecase.dart';

class SignupApi {
  final DioClient _dioClient;
  SignupApi(this._dioClient);
  Future<void> signup(SignupParams signupParams) async {
    // return _dioClient.post(
    //   EndpointsConst.signup,
    //   options: Options(headers: {'Content-Type': 'application/json'}),
    //   data: signupParams.toJson(),
    // );
    print("================================ở signup API");

    await _dioClient.post(
      EndpointsConst.signup,
      options: Options(headers: {'Content-Type': 'application/json'}),
      data: signupParams.toJson(),
    );
  }
}
