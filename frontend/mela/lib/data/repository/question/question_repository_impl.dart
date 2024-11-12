import 'package:mela/constants/global.dart';
import 'package:mela/domain/entity/question/question_list.dart';
import 'package:mela/domain/repository/question/question_repository.dart';

class QuestionRepositoryImpl extends QuestionRepository{

  @override
  Future<QuestionList> getQuestions() async{
    QuestionList temp = QuestionList(questions: Global.questions);
    return temp;
  }

  @override
  Future<QuestionList> updateQuestions(QuestionList newQuestionList) {
    // TODO: implement updateQuestions
    throw UnimplementedError();
  }

}