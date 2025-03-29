import 'package:flutter_test/flutter_test.dart';
import 'package:mela/domain/repository/user_register/user_signup_repostiory.dart';
import 'package:mela/domain/usecase/user_signup/signup_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'signup_usecase_test.mocks.dart';

// Generate mocks cho UserSignUpRepository
@GenerateMocks([UserSignUpRepository])
void main() {
  late SignupUseCase signupUseCase;
  late MockUserSignUpRepository mockUserSignUpRepository;

  setUp(() {
    mockUserSignUpRepository = MockUserSignUpRepository();
    signupUseCase = SignupUseCase(mockUserSignUpRepository);
  });

  var params = SignupParams(username: "newuser", password: "password123");

  // Test case 1: Đăng ký thành công
  test('Should complete successfully on successful signup', () async {
    when(mockUserSignUpRepository.signup(any)).thenAnswer((_) async => null);

    await signupUseCase.call(params: params);

    verify(mockUserSignUpRepository.signup(params)).called(1);
    verifyNoMoreInteractions(mockUserSignUpRepository);
  });

  // Test case 2: Đăng ký thất bại do tài khoản đã tồn tại
  test('Should throw exception when signup fails due to existing account', () async {
    when(mockUserSignUpRepository.signup(any))
        .thenThrow(Exception("Account already exists"));

    expect(
      () async => await signupUseCase.call(params: params),
      throwsA(isA<Exception>()),
    );

    verify(mockUserSignUpRepository.signup(params)).called(1);
    verifyNoMoreInteractions(mockUserSignUpRepository);
  });
}