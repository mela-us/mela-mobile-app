import 'dart:async';

import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/repository/user_login/user_login_repository.dart';

class RefreshAccessTokenUsecase extends UseCase<bool, void> {
  UserLoginRepository _userLoginRepository;
  RefreshAccessTokenUsecase(this._userLoginRepository);
  @override
  Future<bool> call({required void params}) async {
    try {
      String newAccessToken = await _userLoginRepository.refreshAccessToken();
      if (newAccessToken.isNotEmpty) {
        await _userLoginRepository.saveAccessToken(newAccessToken);
      }
      return true;
    } catch (e) {
      //refreshToken is expired e == ResponseStatus.UNAUTHORIZED or DioException
      return false;
    }
  }
}
