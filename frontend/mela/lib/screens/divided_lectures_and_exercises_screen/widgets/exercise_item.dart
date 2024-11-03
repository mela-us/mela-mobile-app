import 'package:flutter/material.dart';
import 'package:mela/models/lecture.dart';

import '../../../constants/global.dart';
import '../../../models/exercise.dart';
import '../../../themes/default/text_styles.dart';
import 'package:mela/screens/question_screen/QuestionScreen.dart';

class ExerciseItem extends StatelessWidget {
  Exercise currentExercise;

  ExerciseItem({
    required this.currentExercise,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => QuestionScreen(questions: Global.questions,)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Image + completed questions/total questions
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Image.asset(currentExercise.imageExercisePath,
                      width: 60, height: 60),
                  SizedBox(height: 8),
                  TextStandard.MiniCaption(
                    '${currentExercise.numberCompletedQuestions} / ${currentExercise.numberQuestions}',
                    Colors.black,
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),

            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Topic name + level name
                  TextStandard.SubTitle(
                    '${currentExercise.topicName} - ${currentExercise.levelName}',
                    Colors.orange,
                  ),
                  SizedBox(height: 4),
                  // Exercise name
                  TextStandard.SubTitle(
                    currentExercise.exerciseName,
                    Colors.black,
                  ),
                  SizedBox(height: 8),
                  // Number of questions + type of questions
                  TextStandard.Normal(
                    '${currentExercise.numberQuestions} câu | ${currentExercise.typeQuestion}',
                    Colors.black,
                  ),

                  SizedBox(width: 16),

                  //Status of exercise
                  Row(
                    children: [
                      TextStandard.Normal(
                        'Trạng thái:   ',
                        Colors.black,
                      ),
                      TextStandard.Normal(
                        currentExercise.statusExercise ? "Đạt" : "Chưa đạt",
                        currentExercise.statusExercise
                            ? Colors.green
                            : Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 6),
          ],
        ),
      ),
    );
  }
}
