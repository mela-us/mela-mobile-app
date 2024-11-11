import 'package:flutter/material.dart';
import 'package:mela/models/lecture.dart';
import 'package:mela/screens/divided_lectures_and_exercises_screen/widgets/exercise_item.dart';

import '../../../constants/global.dart';
import '../../../domain/entity/lecture/lecture.dart';

class ExerciseListItem extends StatelessWidget {
  Lecture currentLecture;
  ExerciseListItem({
    required this.currentLecture,
  });
  @override
  Widget build(BuildContext context) {
    var exercises = Global.getExercisesInLecture(currentLecture.lectureId);
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        return ExerciseItem(currentExercise: exercises[index]);
      },
    );
  }
}
