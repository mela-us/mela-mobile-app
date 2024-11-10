import 'package:mela/domain/repository/user_register/user_signup_repostiory.dart';
import 'package:mela/domain/usecase/user_signup/signup_usecase.dart';

class UserSignupRepositoryImpl extends UserSignUpRepository {
  @override
  Future<void> signup(SignupParams params) async {
    try {
      // TODO: implement login
      await Future.delayed(Duration(seconds: 5));
      //return await Future.delayed(Duration(seconds: 5), () {
      //throw Exception('Simulated login error');
      //});
    } catch (e) {
      throw e;
    }
  }
}
