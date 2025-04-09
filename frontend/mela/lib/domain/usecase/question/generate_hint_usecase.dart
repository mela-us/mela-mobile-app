import 'package:dio/dio.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/repository/question/hint_repository.dart';
import 'package:mela/domain/usecase/user/logout_usecase.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

class GenerateHintUseCase extends UseCase<String, String> {
  final HintRepository _hintRepository;
  final RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  final LogoutUseCase _logoutUseCase;

  GenerateHintUseCase(
      this._hintRepository, this._refreshAccessTokenUsecase, this._logoutUseCase);

  @override
  Future<String> call({required String params}) async {
    try {
      return await _hintRepository.generateGuide(params);
    } catch (e) {
      if (e is DioException){
        if (e.response?.statusCode  == 401){
          print("🔄 Attempting to refresh token...");
          bool isSuccess = await _refreshAccessTokenUsecase.call(params: null);
          if (isSuccess) {
            return await call(params: params);
          }
          else {
            await _logoutUseCase.call(params: null);
            //temporary
            rethrow;
          }
        } else {
          rethrow;
        }
      }
      rethrow;
    }
  }
}