import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mela/models/Notifiers/question_change_notifier.dart';
import 'package:mela/models/QuestionFamily/AQuestion.dart';
import 'package:mela/models/QuestionFamily/FitbQuestion.dart';
import 'package:provider/provider.dart';

import '../../../constants/global.dart';
import '../../../themes/default/text_styles.dart';

class QuestionView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<QAMixNotifier>(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          questionWidget(notifier),

          const SizedBox(height: 27),

          Padding(
              padding: const EdgeInsets.only(left: 30),
              child: TextStandard.SubTitle(
                  'Đáp án của bạn:',
                  const Color(0xFF545454)
              )
          ),

          const SizedBox(height: 17),

          notifier.question is FitbQuestion ?
          answerWidgetFitb(notifier) : answerWidgetQuiz(notifier),

          notifier.question is FitbQuestion ?
          SizedBox(height: 27) : SizedBox(height: 15),


          Padding(
              padding: const EdgeInsets.only(left: 30),
              child: TextStandard.SubTitle('Giải thích:', Color(0xFF545454)),
          ),

          // SizedBox(height: 17),
          
          explanationWidget('Phần giải thích cho đáp án nằm ở đây'),

        ],
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}

Widget questionWidget(QAMixNotifier notifier){
  return Row(
    children: [
      Expanded(
        child: Container(
          margin: EdgeInsets.fromLTRB(
              30,
              16.0,
              Global.PracticeRightPadding,
              0.0),
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // Đổ bóng
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 18, 15, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [

                  TextStandard.SubTitle(
                      'Câu ${notifier.index+1}:',
                      const Color(0xFFFF6B00)
                  ),

                  const SizedBox(height: 3.0),

                  TextStandard.Content(
                      notifier.question.questionContent,
                      const Color(0xFF393939)
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget explanationWidget(String content){
  return Row(
    children: [
      Expanded(
        child: Container(
          margin: EdgeInsets.fromLTRB(
              30,
              16.0,
              Global.PracticeRightPadding,
              0.0),
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // Đổ bóng
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 18, 15, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [

                  TextStandard.SubTitle(
                      'Lời giải:',
                      const Color(0xFFFF6B00),
                  ),

                  const SizedBox(height: 3.0),

                  TextStandard.Content(
                      content,
                      const Color(0xFF393939)
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

//fitb answer
Widget answerWidgetFitb(QAMixNotifier notifier){
  //answer is correct
  if (isAnswerCorrect(notifier.question, notifier.answer)){
    return correctAnswerFitbView(notifier.answer);
  }

  //answer is incorrect
  else {
    return incorrectAnswerFitbView(notifier.question.answer, notifier.answer);
  }

}

Container correctAnswerFitbView(String answer){
  return Container(
    margin: EdgeInsets.fromLTRB(
        30,
        0,
        Global.PracticeRightPadding,
        0.0),
    decoration: const BoxDecoration(
      color: Colors.transparent,
    ),
    child: answerTile(
        answer,
        Color(0xFF8EFF97),
        Color(0xFF167F71),
        Icons.check_circle
    ),
  );
}

Container incorrectAnswerFitbView(String correctAnswer, String answer){
  return Container(
    margin: EdgeInsets.fromLTRB(
        30,
        0,
        Global.PracticeRightPadding,
        0.0),
    decoration: const BoxDecoration(
      color: Colors.transparent,
    ),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        answerTile(
            answer,
            Color(0xFFFFD5DB),
            Color(0xFFD32F2F),
            Icons.cancel
        ),
        SizedBox(height: 12),
        answerTile(
            correctAnswer,
            Color(0xFF8EFF97),
            Color(0xFF167F71),
            Icons.check_circle
        )
      ],
    )
  );
}

//Quiz answer
Widget answerWidgetQuiz(QAMixNotifier notifier) {
  List<String> quizAnswers = notifier.question.getChoiceList()!;
  print('questionAnswer ${notifier.answer} with userAnswer ${notifier.question.answer}');
  return Container(
    padding: EdgeInsets.fromLTRB(
        30,
        0,
        Global.PracticeRightPadding,
        0.0),
    child: ListView.builder(
      itemCount: quizAnswers.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: quizTile(
              quizAnswers[index],
              index,
              notifier.answer,
              notifier.question.answer
          ),
        );
      },
    ),
  );
}

Container quizTile(
    String quizChoice, int index, String userAnswer, String questionAnswer){
  String choiceKey = convertNumberToLetter(index);
  String newQuizContent = '$choiceKey. $quizChoice';
  if (choiceKey == questionAnswer){
    //correct
    return answerTile(
        newQuizContent, 
        const Color(0xFF8EFF97),
        const Color(0xFF167F71),
        Icons.check_circle
    );
  }

  if (choiceKey == userAnswer){
    //incorrect
    return answerTile(
        newQuizContent, 
        const Color(0xFFFFD5DB),
        const Color(0xFFD32F2F),
        Icons.cancel
    );
  }
  //neutral
  return answerTile(
      newQuizContent,
      Colors.white,
      const Color(0xFF505050),
      Icons.circle_outlined
  );
}

Container answerTile(
    String text, Color backgroundColor, Color textColor, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3), // Đổ bóng
        ),
      ],
    ),
    height: 60.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextStandard.Normal(text, textColor),
        Icon(
          icon,
          color: textColor,
          size: 30.0,
        ),
      ],
    ),
  );
}


bool isAnswerCorrect(AQuestion question, String answer){
  if (answer == question.answer) return true;
  return false;
}

String convertNumberToLetter(int number){
  return String.fromCharCode(number + 65);
}

