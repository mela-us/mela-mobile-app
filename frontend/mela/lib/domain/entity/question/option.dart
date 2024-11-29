class Option {
  final int ordinalNumber;
  final String content;
  final bool isCorrect;

  Option({
    required this.ordinalNumber,
    required this.content,
    required this.isCorrect,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      ordinalNumber: json['ordinalNumber'],
      content: json['content'],
      isCorrect: json['isCorrect'],
    );
  }
}