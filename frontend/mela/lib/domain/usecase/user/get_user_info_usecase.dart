import 'package:mela/domain/entity/user_data/user.dart';

import '../../../core/domain/usecase/use_case.dart';
import '../../entity/user/user.dart';
import '../../repository/user/user_repository.dart';

class GetUserInfoUseCase implements UseCase<UserData, void> {
  final UserRepository _userRepository;

  GetUserInfoUseCase(this._userRepository);

  @override
  Future<UserData> call({required void params}) async {
    return await _userRepository.getUserInfo();
  }
}