import 'dart:async';

import 'package:dio/dio.dart';
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
      return await _lectureRepository.getLectures(params);
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
            return await call(params: params);
          }
          //Call logout, logout will delete token in secure storage, shared preference.....

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
