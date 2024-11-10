import '../../../core/domain/usecase/use_case.dart';
import '../../repository/user_login/user_login_repository.dart';

class IsLoggedInUseCase implements UseCase<bool, void> {
  final UserLoginRepository _userLoginRepository;

  IsLoggedInUseCase(this._userLoginRepository);

  @override
  Future<bool> call({required void params}) async {
    return await _userLoginRepository.isLoggedIn;
  }
}
