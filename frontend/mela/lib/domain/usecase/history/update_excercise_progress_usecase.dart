import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/data/network/apis/history/update_progress_api.dart';
import 'package:mela/data/network/apis/questions/save_result_api.dart';
import 'package:mela/domain/entity/question/exercise_result.dart';
import 'package:mela/domain/params/question/submit_result_params.dart';
import 'package:mela/domain/usecase/user/logout_usecase.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

class UpdateExcerciseProgressUsecase
    extends UseCase<ExerciseResult, SubmitResultParams> {
  // final UpdateProgressApi _updateProgressApi;
  final SaveResultApi _saveResultApi;
  final RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  final LogoutUseCase _logoutUseCase;

  UpdateExcerciseProgressUsecase(this._saveResultApi,
      this._refreshAccessTokenUsecase, this._logoutUseCase);
  @override
  Future<ExerciseResult> call({required SubmitResultParams params}) async {
    try {
      print("reach here in UpdateExcerciseProgressUsecase");
      ExerciseResult result =
          await _saveResultApi.saveResult(params, '/api/exercise-histories');
      print("UpdateExcerciseProgressUsecase: ${result.message}");
      return result;
    } catch (e) {
      print("Exception in UpdateExcerciseProgressUsecase: ${e.toString()}");
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          bool isSuccess = await _refreshAccessTokenUsecase.call(params: null);
          if (isSuccess) {
            return call(params: params);
          } else {
            await _logoutUseCase.call(params: null);
            rethrow;
          }
        }
      }
      return ExerciseResult(message: "", answers: []);
    }
  }
}
