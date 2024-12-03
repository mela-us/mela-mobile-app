import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/repository/forgot_password/forgot_password_repository.dart';

class ChangePasswordParams {
  final String username;
  final String newPassword;
  final String token;
  ChangePasswordParams({
    required this.username,
    required this.newPassword,
    required this.token,
  });
}

class ChangePasswordUseCase extends UseCase<void, ChangePasswordParams> {
  final ForgotPasswordRepository _forgotPasswordRepository;
  ChangePasswordUseCase(this._forgotPasswordRepository);
  @override
  Future<void> call({required ChangePasswordParams params}) {
    return _forgotPasswordRepository.changePassword(params);
  }
}
