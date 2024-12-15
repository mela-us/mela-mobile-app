import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/divided_lectures_and_exercises_screen/store/exercise_store.dart';
import 'package:mela/presentation/home_screen/store/level_store/level_store.dart';

import '../../../domain/entity/lecture/lecture.dart';
import '../../../utils/routes/routes.dart';

class LectureItem extends StatelessWidget {
  final Lecture lecture;
  final _levelStore = getIt<LevelStore>();
  final _exerciseStore = getIt<ExerciseStore>();
  LectureItem({
    Key? key,
    required this.lecture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String topicName = _levelStore.getTopicNameById(lecture.topicId);
    String levelName = _levelStore.getLevelNameById(lecture.levelId);
    return GestureDetector(
      onTap: () {
        _exerciseStore.setCurrentLecture(lecture);
        //Navigator.of(context).pushNamed(Routes.dividedLecturesAndExercisesScreen);
        Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.dividedLecturesAndExercisesScreen,
          (route) {
            final routeName = route.settings.name;
            //if user at search screen, remove search, filter screen
            //if user at lecture in topic screen, not remove this screen
            // Return false to remove search and filter screens
            // Return true to keep other screens
            return routeName != Routes.searchScreen &&
                routeName != Routes.filterScreen;
          },
        );
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
                    child: Text(
                        '${(lecture.progress * 100).toStringAsFixed(0)}%',
                        style: Theme.of(context).textTheme.miniCaption.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 10)),
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
                    // Topic name + level name
                    Text(
                      '$topicName - $levelName',
                      style: Theme.of(context)
                          .textTheme
                          .subTitle
                          .copyWith(color: Colors.orange,fontSize: 12),
                    ),
                    const SizedBox(height:  10),
                    Text(
                      lecture.lectureDescription,
                      style: Theme.of(context).textTheme.normal.copyWith(
                          color: Theme.of(context).colorScheme.secondary, fontSize: 10),
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
                    size: 24,
                    color: Theme.of(context).colorScheme.onTertiary,
                  )), // Play icon
            ],
          ),
        ),
      ),
    );
  }
}
