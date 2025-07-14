import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mela/core/data/network/constants/network_constants.dart';
import 'package:mela/core/data/network/dio/configs/dio_configs.dart';
import 'package:mela/data/network/apis/login_signup/signup_api.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/domain/usecase/user_signup/signup_usecase.dart';

void main() {
  late SignupApi signupApi;

  setUp(() {
    signupApi = SignupApi(
      DioClient(
        dioConfigs: const DioConfigs(baseUrl: NetworkConstants.mockUrl),
      ),
    );
  });

  group('[<--Signup POST/api/register-->]', () {
    final signupParams = SignupParams(username: "test@mail.com", password: "123");

    test('Success => Completes without throwing exception', () async {
      await signupApi.signup(signupParams);
    });

    test('Failed with existing account => Throw DioException', () async {
      final existingParams = SignupParams(username: "existaccount@mail.com", password: "123");
      expect(
        () async => await signupApi.signup(existingParams),
        throwsA(isA<DioException>()),
      );
    });
  });
}