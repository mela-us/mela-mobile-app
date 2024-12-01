import '../../../core/domain/usecase/use_case.dart';
import '../../repository/user_login/user_login_repository.dart';

class SaveRefreshTokenUsecase implements UseCase<void, String> {
  final UserLoginRepository _userLoginRepository;

  SaveRefreshTokenUsecase(this._userLoginRepository);

  @override
  Future<void> call({required String params}){
    return _userLoginRepository.saveRefreshToken(params);
  }
}