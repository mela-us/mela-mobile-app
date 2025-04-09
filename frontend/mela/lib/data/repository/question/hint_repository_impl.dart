import 'package:mela/data/network/apis/questions/hint_api.dart';
import 'package:mela/domain/entity/question/question_list.dart';
import 'package:mela/domain/repository/question/hint_repository.dart';

class HintRepositoryImpl implements HintRepository{
  final HintApi hintApi;
  HintRepositoryImpl(this.hintApi);

  @override
  Future<String> generateGuide(String questionId) async{
    try {
      String guide = await hintApi.generateGuide(questionId);
      return guide;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> generateTerm(String questionId) async{
    try {
      String term = await hintApi.generateTerm(questionId);
      return term;
    } catch (e) {
      rethrow;
    }
  }
}