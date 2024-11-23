import '../../../core/domain/usecase/use_case.dart';
import '../../entity/user/user.dart';
import '../../repository/user/user_repository.dart';

class GetUserInfoUseCase implements UseCase<User, void> {
  final UserRepository _userRepository;

  GetUserInfoUseCase(this._userRepository);

  @override
  Future<User> call({required void params}) async {
    return await _userRepository.getUserInfo();
  }
}