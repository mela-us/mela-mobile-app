import 'package:dio/dio.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/entity/lecture/lecture_list.dart';
import 'package:mela/domain/repository/lecture/lecture_repository.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

class GetLecturesAreLearningUsecase extends UseCase<LectureList, void> {
  LectureRepository _lectureRepository;
  RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  GetLecturesAreLearningUsecase(
      this._lectureRepository, this._refreshAccessTokenUsecase);
  @override
  Future<LectureList> call({void params}) async {
    try {
      return _lectureRepository.getLecturesAreLearning();
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
