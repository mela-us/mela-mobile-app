import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mela/core/data/network/constants/network_constants.dart';
import 'package:mela/core/data/network/dio/configs/dio_configs.dart';
import 'package:mela/data/network/apis/login_signup/login_api.dart';
import 'package:mela/data/network/constants/endpoints_const.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/domain/entity/user/token_model.dart';
import 'package:mela/domain/usecase/user_login/login_usecase.dart';

void main() {
  late LoginApi loginApi;

  setUp(() {
    loginApi = LoginApi(
      DioClient(
        dioConfigs: const DioConfigs(baseUrl: NetworkConstants.mockUrl),
      ),
    );
  });

  group('[<--Login POST/api/login-->]', () {
    final loginParams = LoginParams(username: "test@mail.com", password: "123");

    test('Success => Return TokenModel with real API data', () async {
      final result = await loginApi.login(loginParams);

      expect(result, isA<TokenModel>());
      expect(result.accessToken, isNotNull);
      expect(result.refreshToken, isNotNull); // Kiểm tra refreshToken không null
    });

    test('Failed with wrong credentials => Throw DioException', () async {

      final wrongParams = LoginParams(username: "wrongusername", password: "wrongpassword");

      expect(
        () async => await loginApi.login(wrongParams),
       throwsException,
      );
    });
  });
}