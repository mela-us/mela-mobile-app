import 'dart:async';

import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/entity/question/question_list.dart';
import 'package:mela/domain/repository/question/question_repository.dart';

class GetQuestionsUseCase extends UseCase<QuestionList, String>{
  final QuestionRepository _questionRepository;

  GetQuestionsUseCase(this._questionRepository);

  @override
  Future<QuestionList> call({required params}) {
    return _questionRepository.getQuestions(params);
  }
}