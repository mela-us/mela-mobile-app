import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

import '../../entity/exercise/exercise_list.dart';
import '../../repository/exercise/exercise_repository.dart';

class GetExercisesUseCase extends UseCase<ExerciseList, String> {
  final ExerciseRepository _exerciseRepository;
  RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  GetExercisesUseCase(this._exerciseRepository, this._refreshAccessTokenUsecase);

  @override
  Future<ExerciseList> call({required String params}) async {
    try {
      return _exerciseRepository.getExercises(params);
    } catch (e) {
      if (e is DioException) {
        //eg timeout, no wifi,...
        rethrow;
      }

      // UNAUTHORIZED, call refreshToken
      if (e == ResponseStatus.UNAUTHORIZED) {
        bool isRefreshTokenSuccess =
            await _refreshAccessTokenUsecase.call(params: null);
        if (isRefreshTokenSuccess) {
          //not use return _lectureRepository.getLectures(params); in here beacause if do it
          //it have a DioException, so we should call recursive
          return call(params: params);
        } else {
          throw ResponseStatus.UNAUTHORIZED;
        }
      }
      rethrow;
    }

  }
}