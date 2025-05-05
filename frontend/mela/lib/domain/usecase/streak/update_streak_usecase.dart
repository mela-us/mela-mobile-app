import 'package:dio/dio.dart';

import '../../../core/domain/usecase/use_case.dart';
import '../../repository/streak/streak_repository.dart';
import '../user/logout_usecase.dart';
import '../user_login/refresh_access_token_usecase.dart';

class UpdateStreakUseCase implements UseCase<bool, void> {
  final StreakRepository _repo;
  final RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  final LogoutUseCase _logoutUseCase;

  UpdateStreakUseCase(this._repo, this._refreshAccessTokenUsecase, this._logoutUseCase);

  @override
  Future<bool> call({required params}) async {
    try {
      return await _repo.updateStreak();
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