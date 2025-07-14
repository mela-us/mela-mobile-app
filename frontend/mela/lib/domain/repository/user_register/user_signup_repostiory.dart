

import '../../usecase/user_signup/signup_usecase.dart';

abstract class UserSignUpRepository {
  Future<void> signup(SignupParams params);
}
