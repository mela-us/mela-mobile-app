import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/data/network/apis/questions/save_result_api.dart';
import 'package:mela/domain/usecase/user/logout_usecase.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

import '../../params/question/submit_result_params.dart';

class SubmitResultUseCase extends UseCase<int, SubmitResultParams>{
  final SaveResultApi _saveApi;
  final RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  final LogoutUseCase _logoutUseCase;

  SubmitResultUseCase(
      this._saveApi, this._refreshAccessTokenUsecase, this._logoutUseCase);
  @override
  Future<int> call({required SubmitResultParams params}) async {
    try {
      int resultCode = await _saveApi.saveResult(params);
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