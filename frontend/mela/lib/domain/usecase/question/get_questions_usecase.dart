import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/entity/question/question_list.dart';
import 'package:mela/domain/repository/question/question_repository.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

import '../user/logout_usecase.dart';

class GetQuestionsUseCase extends UseCase<QuestionList?, String>{
  final QuestionRepository _questionRepository;
  final RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  final LogoutUseCase _logoutUseCase;

  GetQuestionsUseCase(
      this._questionRepository,
      this._refreshAccessTokenUsecase,
      this._logoutUseCase
      );

  @override
  Future<QuestionList?> call({required params}) async {
    try {
      return await _questionRepository.getQuestions(params);
    }catch (e){
      if (e is DioException){
        if (e.response?.statusCode  == 401){
          print("🔄 Attempting to refresh token...");
          bool isSuccess = await _refreshAccessTokenUsecase.call(params: null);
          if (isSuccess) {
            return await call(params: params);
          }
          else {
            await _logoutUseCase.call(params: null);
            //temporary
            rethrow;
          }
        } else {
          return null;
        }
      }
      return null;
    }
  }
}