import 'package:mela/data/network/apis/login_signup/signup_api.dart';
import 'package:mela/domain/repository/user_register/user_signup_repostiory.dart';
import 'package:mela/domain/usecase/user_signup/signup_usecase.dart';

class UserSignupRepositoryImpl extends UserSignUpRepository {
  final SignupApi _signupApi;
  UserSignupRepositoryImpl(this._signupApi);
  @override
  Future<void> signup(SignupParams params) {
    return _signupApi.signup(params);
  }
}
