import 'package:mela/constants/global.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/domain/entity/question/question_list.dart';
import 'package:mela/domain/repository/question/question_repository.dart';

import '../../network/apis/questions/questions_api.dart';

class QuestionRepositoryImpl extends QuestionRepository{
  final QuestionsApi _questionsApi;

  QuestionRepositoryImpl(this._questionsApi);

  @override
  Future<QuestionList> getQuestions(String exerciseUid) async{
    try {
      QuestionList temp = await _questionsApi.getQuestions(exerciseUid);
      return temp;
    }
    catch (e){
      print('Error 2nd: $e');
      return QuestionList(questions:  [], message: '', size: 0);
    }
  }

  @override
  Future<QuestionList> updateQuestions(QuestionList newQuestionList) {
    // TODO: implement updateQuestions
    throw UnimplementedError();
  }
}