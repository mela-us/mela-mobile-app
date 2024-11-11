import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/divided_lectures_and_exercises_screen/store/exercise_store.dart';

import '../../../domain/entity/lecture/lecture.dart';
import '../../../utils/routes/routes.dart';

class LectureItem extends StatelessWidget {
  final Lecture lecture;

  const LectureItem({
    Key? key,
    required this.lecture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ExerciseStore _exerciseStore = getIt<ExerciseStore>();
    return GestureDetector(
      onTap: () {
        _exerciseStore.setLectureId(lecture.lectureId);
        Navigator.of(context).pushNamed(Routes.dividedLecturesAndExercisesScreen);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onTertiary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              // Circular progress indicator around the lectureId
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      value: lecture
                          .progress, // Set progress value here (from 0.0 to 1.0)
                      strokeWidth: 3,
                      color: Theme.of(context).colorScheme.tertiary,
                      backgroundColor: Colors.grey[200],
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 16,
                    child: Text(lecture.lectureId.toString(),
                        style: Theme.of(context).textTheme.normal.copyWith(
                            color: Theme.of(context).colorScheme.secondary)),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              //Title and description of the lecture
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lecture.lectureName,
                      style: Theme.of(context).textTheme.subTitle.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      lecture.lectureDescription,
                      style: Theme.of(context).textTheme.normal.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),

              //Button to play the lecture
              Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    size: 20,
                    color: Theme.of(context).colorScheme.onTertiary,
                  )), // Play icon
            ],
          ),
        ),
      ),
    );
  }
}
