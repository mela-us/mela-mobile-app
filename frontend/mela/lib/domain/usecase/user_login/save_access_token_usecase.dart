import '../../../core/domain/usecase/use_case.dart';
import '../../repository/user_login/user_login_repository.dart';

class SaveAccessTokenUsecase implements UseCase<void, String> {
  final UserLoginRepository _userLoginRepository;

  SaveAccessTokenUsecase(this._userLoginRepository);

  @override
  Future<void> call({required String params}){
    return _userLoginRepository.saveAccessToken(params);
  }
}