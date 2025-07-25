import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mela/domain/entity/topic_lecture_in_level/topic_lecture_in_level_list.dart';
import 'package:mela/domain/repository/topic_lecture/topic_lecture_repository.dart';
import 'package:mela/domain/usecase/user/logout_usecase.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

import '../../../core/domain/usecase/use_case.dart';
class GetTopicLectureUsecase extends UseCase<TopicLectureInLevelList, String> {
  final TopicLectureRepository _topicLectureRepository;
  final RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  final LogoutUseCase _logoutUseCase;

  GetTopicLectureUsecase(this._topicLectureRepository,
      this._refreshAccessTokenUsecase, this._logoutUseCase);

  @override
  Future<TopicLectureInLevelList> call({required String params}) async {
    try {
      return await _topicLectureRepository.getTopicLectureList(params);
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
