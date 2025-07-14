import 'package:dio/dio.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/repository/lecture/lecture_repository.dart';
import 'package:mela/domain/usecase/user/logout_usecase.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

class UpdateSuggestionParams {
  final String suggestionId;
  final String lectureId;
  int ordinalNumber;
  bool isDone;

  UpdateSuggestionParams({
    required this.suggestionId,
    required this.lectureId,
    required this.ordinalNumber,
    required this.isDone,
  });

  Map<String, dynamic> toMap() {
    return {
      'itemId': lectureId,
      'ordinalNumber': ordinalNumber,
      'isDone': isDone,
    };
  }
}

class UpdateSuggestionUsecase extends UseCase<void, UpdateSuggestionParams> {
  final LectureRepository _lectureRepository;
  RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  LogoutUseCase _logoutUseCase;

  UpdateSuggestionUsecase(
    this._lectureRepository,
    this._refreshAccessTokenUsecase,
    this._logoutUseCase,
  );
  @override
  Future<void> call({required UpdateSuggestionParams params}) async {
    try {
      print(
          "Sa2 ====>Updating suggestion in usecase: ${params.suggestionId}, ${params.lectureId}, ${params.ordinalNumber}, ${params.isDone}");
      await _lectureRepository.updateSuggestion(params);
    } catch (e) {
      if (e is DioException) {
        //eg accessToken is expired
        if (e.response?.statusCode == 401) {
          bool isRefreshTokenSuccess =
              await _refreshAccessTokenUsecase.call(params: null);
          if (isRefreshTokenSuccess) {
            print(
                "----------->E1 error is refresh token in review submission: $e");
            return await call(params: params);
          }
          //Call logout, logout will delete token in secure storage, shared preference.....
          await _logoutUseCase.call(params: null);
          rethrow;
          //.................
        }
        print("----------->E2 in  in review submission: $e");
        rethrow;
      }
      print("----------->E3 in  in review submissionn: $e");
      rethrow;
    }
  }
}
