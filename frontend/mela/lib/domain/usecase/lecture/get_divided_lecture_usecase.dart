import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/entity/divided_lecture/divided_lecture_list.dart';
import 'package:mela/domain/repository/lecture/lecture_repository.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

class GetDividedLectureUsecase extends UseCase<DividedLectureList, String> {
  LectureRepository _lectureRepository;
  RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  GetDividedLectureUsecase(
      this._lectureRepository, this._refreshAccessTokenUsecase);

  @override
  Future<DividedLectureList> call({required String params}) async {
    try {
      return _lectureRepository.getDividedLectureList(params);
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
