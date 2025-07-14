import 'package:dio/dio.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/entity/revise/revise.dart';
import 'package:mela/domain/repository/revise/revise_repository.dart';
import 'package:mela/domain/usecase/user/logout_usecase.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

class GetRevisionUsecase extends UseCase<UserReviewsResponse, void> {
  final ReviseRepository _reviseRepository;
  final RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  final LogoutUseCase _logoutUseCase;
  GetRevisionUsecase(this._reviseRepository, this._refreshAccessTokenUsecase,
      this._logoutUseCase);

  @override
  Future<UserReviewsResponse> call({required void params}) async {
    try {
      return await _reviseRepository.getRevise();
    } catch (e) {
      if (e is DioException) {
        //eg accessToken is expired
        if (e.response?.statusCode == 401) {
          bool isRefreshTokenSuccess =
              await _refreshAccessTokenUsecase.call(params: null);
          if (isRefreshTokenSuccess) {
            //not use return _lectureRepository.getLectures(params); in here beacause if do it
            //it have a DioException, so we should call recursive
            print("----------->E1: $e");
            return await call(params: null);
          }
          //Call logout, logout will delete token in secure storage, shared preference.....
          await _logoutUseCase.call(params: null);
          rethrow;
          //.................
        }
        print("----------->E2: $e");
        rethrow;
      }
      print("----------->E3: $e");
      rethrow;
    }
  }
}
