import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/repository/question/question_repository.dart';
import 'package:mela/domain/usecase/user/logout_usecase.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

class UploadImagesUsecase
    extends UseCase<List<List<String>?>, List<List<File>>> {
  final QuestionRepository _questionRepository;
  final RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  final LogoutUseCase _logoutUseCase;

  UploadImagesUsecase(this._questionRepository, this._refreshAccessTokenUsecase,
      this._logoutUseCase);

  @override
  Future<List<List<String>?>> call({required List<List<File>> params}) async {
    try {
      return await _questionRepository.uploadImages(params);
    } catch (e) {
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
      return Future.error(e);
    }
  }
}
