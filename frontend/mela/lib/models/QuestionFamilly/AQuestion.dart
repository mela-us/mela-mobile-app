abstract class AQuestion{
  final String id;
  final String questionContent;
  final String answer;
  final List<String>? imageUrl;

  AQuestion({
  required this.id,
  required this.questionContent,
  required this.answer,
  required this.imageUrl
  });

  bool isCorrect(String userAnswer);
}