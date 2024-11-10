import '../../../core/domain/usecase/use_case.dart';
import '../../repository/user_login/user_login_repository.dart';

class SaveLoginStatusUseCase implements UseCase<void, bool> {
  final UserLoginRepository _userLoginRepository;

  SaveLoginStatusUseCase(this._userLoginRepository);

  @override
  Future<void> call({required bool params}){
    return _userLoginRepository.saveIsLoggedIn(params);
  }
}