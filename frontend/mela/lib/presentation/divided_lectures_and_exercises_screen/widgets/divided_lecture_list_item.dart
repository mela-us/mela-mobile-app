// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:mela/presentation/divided_lectures_and_exercises_screen/store/exercise_store.dart';

import '../../../di/service_locator.dart';
import '../../../domain/entity/divided_lecture/divided_lecture.dart';
import '../../../domain/entity/divided_lecture/divided_lecture_list.dart';
import 'divided_lecture_item.dart';

class DividedLectureListItem extends StatelessWidget {
  final ExerciseStore _exerciseStore = getIt<ExerciseStore>();
  final void Function() onGoToExercise;
  DividedLectureListItem({super.key, required this.onGoToExercise});

  @override
  Widget build(BuildContext context) {
    //String currentContentLectures = _exerciseStore.currentLecture!.lectureContent;
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _exerciseStore.dividedLectureList!.dividedLectures.length,
      itemBuilder: (context, index) {
        return DividedLectureItem(
            currentDividedLecture:
                _exerciseStore.dividedLectureList!.dividedLectures[index],
            onGoToExercise: onGoToExercise);
      },
    );
  }
}
