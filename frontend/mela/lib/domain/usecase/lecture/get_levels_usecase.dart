import 'package:dio/dio.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/repository/lecture/lecture_repository.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

import '../../entity/level/level_list.dart';

class GetLevelsUsecase extends UseCase<LevelList, void> {
  final LectureRepository _lectureRepository;
  final RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  GetLevelsUsecase(this._lectureRepository, this._refreshAccessTokenUsecase);
  @override
  Future<LevelList> call({required void params}) async {

    try {
      return _lectureRepository.getLevels();
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
            return call(params: null);
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
