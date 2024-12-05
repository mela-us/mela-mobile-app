import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/repository/forgot_password/forgot_password_repository.dart';

class CreateNewPasswordParams {
  final String username;
  final String newPassword;
  final String token;
  CreateNewPasswordParams({
    required this.username,
    required this.newPassword,
    required this.token,
  });
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'newPassword': newPassword,
      'token': token,
    };
  }
}

class CreateNewPasswordUsecase extends UseCase<void, CreateNewPasswordParams> {
  final ForgotPasswordRepository _forgotPasswordRepository;
  CreateNewPasswordUsecase(this._forgotPasswordRepository);
  @override
  Future<void> call({required CreateNewPasswordParams params}) {
    return _forgotPasswordRepository.createNewPassword(params);
  }
}
