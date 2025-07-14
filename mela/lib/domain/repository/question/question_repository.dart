import 'dart:io';

import '../../entity/question/question_list.dart';

abstract class QuestionRepository {
  Future<QuestionList> getQuestions(String exerciseUid);
  Future<QuestionList> updateQuestions(QuestionList newQuestionList);
  Future<List<List<String>?>> uploadImages(List<List<File>> images);

  Future<int> submitQuestion(
      String exerciseUid, String questionText, List<String> imageUrls);
}
