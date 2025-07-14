import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/data/network/apis/history/update_progress_api.dart';
import 'package:mela/domain/params/history/section_progress_params.dart';
import 'package:mela/domain/usecase/user/logout_usecase.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

class UpdateSectionProgressUsecase extends UseCase<int, SectionProgressParams>{
  final UpdateProgressApi _updateProgressApi;
  final RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  final LogoutUseCase _logoutUseCase;

  UpdateSectionProgressUsecase(
      this._updateProgressApi, this._refreshAccessTokenUsecase, this._logoutUseCase);
  @override
  Future<int> call({required SectionProgressParams params}) async {
    try {
      int resultCode = await _updateProgressApi.updateSectionProgress(params);
      return resultCode;
    } catch (e){
      if (e is DioException){
        if (e.response?.statusCode  == 401){
          bool isSuccess = await _refreshAccessTokenUsecase.call(params: null);
          if (isSuccess) {
            return call(params: params);
          }
          else {
            await _logoutUseCase.call(params: null);
            rethrow;
          }
        }
      }
      return -1;
    }
  }
}