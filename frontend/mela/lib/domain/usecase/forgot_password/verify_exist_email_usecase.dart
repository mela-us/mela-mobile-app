import 'dart:async';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/repository/forgot_password/forgot_password_repository.dart';

class VerifyExistEmailUseCase extends UseCase<void, String> {
  final ForgotPasswordRepository _forgotPasswordRepository;
  VerifyExistEmailUseCase(this._forgotPasswordRepository);

  @override
  Future<void> call({required String params}) {
    return _forgotPasswordRepository.verifyExistEmail(params);
  }
}
