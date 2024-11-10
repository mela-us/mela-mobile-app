import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mela/constants/answer_status.dart';
import 'package:mela/models/Notifiers/question_change_notifier.dart';
import 'package:mela/models/QuestionFamily/AQuestion.dart';
import 'package:mela/screens/review_screen/widgets/question_item_tile.dart';
import 'package:provider/provider.dart';

class QuestionListBar extends StatelessWidget{
  final List<AQuestion> questions;
  final List<String> answers;

  const QuestionListBar({
    super.key, required this.questions, required this.answers
  });

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<QAMixNotifier>(context);

    return Container(
      height: 134,
      color: Colors.white,
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 61),
        itemCount: questions.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return InkWell(
            borderRadius: BorderRadius.circular(90),
            onTap: () => _onQuestionSelected(notifier, i),
            child: QuestionTile(
                answerStatus: getStatus(questions[i], answers[i]),
                index: i,
                isSelected: i == notifier.index ? true : false
            ),
          );
        },
      ),
    );


  }

  void _onQuestionSelected(QAMixNotifier notifier, int index) {
    notifier.updateQAMix(questions[index], index, answers[index]);
  }
}

AnswerStatus getStatus(AQuestion q, String a){
  if (a.isEmpty) return AnswerStatus.NoAnswer;
  if (a == q.answer) return AnswerStatus.Correct;
  return AnswerStatus.Incorrect;
}
