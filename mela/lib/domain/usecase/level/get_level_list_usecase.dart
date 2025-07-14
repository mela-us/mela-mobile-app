import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/entity/level/level_list.dart';
import 'package:mela/domain/repository/level/level_repository.dart';
import 'package:mela/domain/usecase/user/logout_usecase.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

class GetLevelListUsecase extends UseCase<void, LevelList> {
  final LevelRepository _levelRepository;
  final RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  final LogoutUseCase _logoutUseCase;
  GetLevelListUsecase(this._levelRepository, this._refreshAccessTokenUsecase,
      this._logoutUseCase);
  @override
  Future<LevelList> call({required void params}) async {
    //it not use accessToken so do not need to refresh accessToken
    try {
      return await _levelRepository.getLevels();
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
