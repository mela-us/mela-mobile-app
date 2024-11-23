import 'package:flutter/material.dart';
import 'package:mela/presentation/divided_lectures_and_exercises_screen/store/exercise_store.dart';

import '../../../di/service_locator.dart';
import 'exercise_item.dart';

class ExerciseListItem extends StatelessWidget {
  final ExerciseStore _exerciseStore = getIt<ExerciseStore>();
  ExerciseListItem();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: _exerciseStore.exerciseList!.exercises.length,
      itemBuilder: (context, index) {
        return ExerciseItem(
            currentExercise: _exerciseStore.exerciseList!.exercises[index]);
      },
    );
  }
}
