import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/repository/user/user_repository.dart';
import 'package:mela/domain/usecase/user/logout_usecase.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

class GetUploadPresignUseCase extends UseCase<String, void> {
  final UserRepository _userRepository;
  final RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  final LogoutUseCase _logoutUseCase;

  GetUploadPresignUseCase(this._userRepository, this._refreshAccessTokenUsecase, this._logoutUseCase);

  @override
  Future<String> call({required void params}) async{
    try {
      return await _userRepository.getImageUpdatePresign();
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          bool isRefreshTokenSuccess = await _refreshAccessTokenUsecase.call(params: null);
          if (isRefreshTokenSuccess) {
            return call(params: null);
          }
          await _logoutUseCase.call(params: null);
          rethrow;
        }
        rethrow;
      }
      rethrow;
    }
  }
}