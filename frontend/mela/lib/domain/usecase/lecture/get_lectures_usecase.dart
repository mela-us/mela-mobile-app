import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

import '../../../core/domain/usecase/use_case.dart';
import '../../entity/lecture/lecture_list.dart';
import '../../repository/lecture/lecture_repository.dart';

class GetLecturesUsecase extends UseCase<LectureList, String> {
  final LectureRepository _lectureRepository;
  final RefreshAccessTokenUsecase _refreshAccessTokenUsecase;

  GetLecturesUsecase(this._lectureRepository, this._refreshAccessTokenUsecase);

  @override
  Future<LectureList> call({required String params}) async {
    try {
      return _lectureRepository.getLectures(params);
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
