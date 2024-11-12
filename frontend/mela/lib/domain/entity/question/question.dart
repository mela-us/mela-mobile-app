class Question{
  String? id;
  String? content;
  String? answer;
  List<String>? imageUrl;
  List<String>? choiceList;


  Question(
      {this.id, this.content, this.answer, this.imageUrl, this.choiceList});

  factory Question.fromMap(Map<String, dynamic> json) => Question(
    id: json["id"],
    content: json["content"],
    answer: json["answer"],
    imageUrl: List<String>.from(json["body"]??[]),
    choiceList: List<String>.from(json["choices"]??[]),
  );


  // Map<String, dynamic> toMap() {
  //   throw UnimplementedError('toMap() must be implemented in a subclass');
  // }

  List<String>? getChoiceList(){
    return choiceList;
  }

  bool isCorrect(String userAnswer){
    if (userAnswer == answer) return true;
    return false;
  }
}