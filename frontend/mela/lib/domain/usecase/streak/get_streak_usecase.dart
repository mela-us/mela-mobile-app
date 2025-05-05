import 'package:dio/dio.dart';

import '../../../core/domain/usecase/use_case.dart';
import '../../entity/streak/streak.dart';
import '../../repository/streak/streak_repository.dart';
import '../user/logout_usecase.dart';
import '../user_login/refresh_access_token_usecase.dart';

class GetStreakUseCase implements UseCase<Streak, void> {
  final StreakRepository _repo;
  final RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  final LogoutUseCase _logoutUseCase;

  GetStreakUseCase(this._repo, this._refreshAccessTokenUsecase, this._logoutUseCase);

  @override
  Future<Streak> call({required params}) async {
    try {
      return await _repo.getStreak();
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