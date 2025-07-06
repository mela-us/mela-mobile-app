import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/data/network/apis/login_signup/refresh_access_token_api.dart';
import 'package:mela/domain/entity/exam/exam.dart';
import 'package:mela/domain/repository/exam/exam_repository.dart';
import 'package:mela/domain/usecase/user/logout_usecase.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

class GetExamUsecase extends UseCase<ExamModel, void> {
  final ExamRepository _examRepository;
  final RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  final LogoutUseCase _logoutUseCase;

  GetExamUsecase(
    this._examRepository,
    this._refreshAccessTokenUsecase,
    this._logoutUseCase,
  );

  @override
  Future<ExamModel> call({required void params}) async {
    try {
      return await _examRepository.getExam();
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          print("🔄 Attempting to refresh token...");
          bool isSuccess = await _refreshAccessTokenUsecase.call(params: null);
          if (isSuccess) {
            return await call(params: null);
          } else {
            await _logoutUseCase.call(params: null);
            //temporary
            rethrow;
          }
        } else {
          rethrow;
        }
      }
      rethrow;
    }
  }
}
