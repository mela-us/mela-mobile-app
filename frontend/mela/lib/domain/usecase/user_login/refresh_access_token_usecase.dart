import 'dart:async';

import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/repository/user_login/user_login_repository.dart';

class RefreshAccessTokenUsecase extends UseCase<bool, void> {
  UserLoginRepository _userLoginRepository;
  RefreshAccessTokenUsecase(this._userLoginRepository);
  @override
  Future<bool> call({required void params}) async {
    try {
      //Must have to request not add authInterceptor into request
      await _userLoginRepository.saveAccessToken("");
      
      String newAccessToken = await _userLoginRepository.refreshAccessToken();

      //print("New access Token Khi het han la: $newAccessToken");
      if (newAccessToken.isNotEmpty) {
        await _userLoginRepository.saveAccessToken(newAccessToken);
      }
      return true;
    } catch (e) {
      //print("Lúc lấy new access bị lỗi $e");
      //refreshToken is expired e == ResponseStatus.UNAUTHORIZED or DioException
      return false;
    }
  }
}
