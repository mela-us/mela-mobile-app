import 'package:mela/domain/repository/forgot_password/forgot_password_repository.dart';
import 'package:mela/domain/usecase/forgot_password/create_new_password_usecase.dart';
import 'package:mela/domain/usecase/forgot_password/verify_otp_usecase.dart';

class ForgotPasswordRepositoryImpl extends ForgotPasswordRepository{

  @override
  Future<void> verifyExistEmail(String email) async{
    print("===================Vao verifyExistEmail");
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Future<String> verifyOTP(OTPParams params) async{
    print("===================Vao verifyOTP");
    await Future.delayed(Duration(seconds: 2));
    //return token
    return "tokentokentoken";
  }
  
  @override
  Future<void> createNewPassword(CreateNewPasswordParams params) async {
    print("===================Vao changePassword");
    await Future.delayed(Duration(seconds: 2));
  }
}