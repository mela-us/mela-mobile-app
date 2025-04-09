abstract class HintRepository {
  Future<String> generateGuide(String questionId);
  Future<String> generateTerm(String questionId);
}