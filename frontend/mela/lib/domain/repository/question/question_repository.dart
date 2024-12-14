import '../../entity/question/question_list.dart';


abstract class QuestionRepository{
  Future<QuestionList> getQuestions(String exerciseUid);
  Future<QuestionList> updateQuestions(QuestionList newQuestionList);
}