import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/entity/question/question_list.dart';
import 'package:mela/domain/repository/question/question_repository.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

class GetQuestionsUseCase extends UseCase<QuestionList?, String>{
  final QuestionRepository _questionRepository;
  final RefreshAccessTokenUsecase _refreshAccessTokenUsecase;

  GetQuestionsUseCase(this._questionRepository, this._refreshAccessTokenUsecase);

  @override
  Future<QuestionList?> call({required params}) async {
    try {
      return await _questionRepository.getQuestions(params);
    }catch (e){
      if (e is DioException){
        if (e.response?.statusCode  == 401){
          bool isSuccess = await _refreshAccessTokenUsecase.call(params: null);
          if (isSuccess) {
            return call(params: params);
          }
          else {
            rethrow;
          }
        }
      }
      return null;
    }
  }
}