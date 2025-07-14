import 'package:flutter_test/flutter_test.dart';
import 'package:mela/domain/entity/user/token_model.dart';
import 'package:mela/domain/repository/user_login/user_login_repository.dart';
import 'package:mela/domain/usecase/user_login/login_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_usecase_test.mocks.dart';

// Generate mocks cho UserLoginRepository
@GenerateMocks([UserLoginRepository])
void main() {
  late LoginUseCase loginUseCase;
  late MockUserLoginRepository mockUserLoginRepository;

  setUp(() {
    mockUserLoginRepository = MockUserLoginRepository();
    loginUseCase = LoginUseCase(mockUserLoginRepository);
  });

  var params = LoginParams(username: "testuser", password: "password123");

  // Test case 1: Login thành công
  test('Should return TokenModel on successful login', () async {
    final tokenModel = TokenModel(accessToken: "mock_access_token", refreshToken: "mock_refresh_token");
    when(mockUserLoginRepository.login(any)).thenAnswer((_) async => tokenModel);

    final result = await loginUseCase.call(params: params);

    expect(result, tokenModel);
    verify(mockUserLoginRepository.login(params)).called(1);
    verifyNoMoreInteractions(mockUserLoginRepository);
  });

  // Test case 2: Login thất bại do thông tin sai
  test('Should return null when login fails', () async {
    when(mockUserLoginRepository.login(any)).thenAnswer((_) async => null);

    final result = await loginUseCase.call(params: params);

    expect(result, null);
    verify(mockUserLoginRepository.login(params)).called(1);
    verifyNoMoreInteractions(mockUserLoginRepository);
  });
}