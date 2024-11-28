import 'package:dio/dio.dart';
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
      await _dioClient.post(
        EndpointsConst.signup,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: signupParams.toJson(),
      
      );
      final requestOptions = RequestOptions(path: '/api/register');
      if (DateTime.now().minute % 2 == 0) {
        throw DioException(
          requestOptions: requestOptions,
          response: Response(
            requestOptions: requestOptions,
            statusCode: 400,
            data: {
              "message": "Email already exists",
              "status": "UNAUTHORIZED",
              "time": "2024-11-26T19:58:40.3939856",
            },
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
