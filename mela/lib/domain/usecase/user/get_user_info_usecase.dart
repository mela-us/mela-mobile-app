import 'package:dio/dio.dart';
import 'package:mela/domain/entity/user/user.dart';

import '../../../core/domain/usecase/use_case.dart';
import '../../repository/user/user_repository.dart';
import '../user_login/refresh_access_token_usecase.dart';
import 'logout_usecase.dart';

class GetUserInfoUseCase implements UseCase<User, void> {
  final UserRepository _userRepository;
  final RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  final LogoutUseCase _logoutUseCase;

  GetUserInfoUseCase(this._userRepository, this._refreshAccessTokenUsecase, this._logoutUseCase);

  @override
  Future<User> call({required params}) async {
    try {
      User user = await _userRepository.getUserInfo();
      return user;
    } catch (e) {
      if (e is DioException) {
        //eg accessToken is expired
        if (e.response?.statusCode == 401) {
          bool isRefreshTokenSuccess =
          await _refreshAccessTokenUsecase.call(params: null);
          if (isRefreshTokenSuccess) {
            print("----------->E1: $e");
            return await call(params: null);
          }
          await _logoutUseCase.call(params: null);
          rethrow;
        }
        print("----------->E2: $e");
        rethrow;
      }
      print("----------->E3: $e");
      rethrow;
    }
  }
}