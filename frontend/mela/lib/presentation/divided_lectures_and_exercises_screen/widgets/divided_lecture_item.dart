import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/content_in_divided_lecture_screen/content_in_divided_lecture_screen.dart';
import 'package:mela/presentation/home_screen/store/level_store/level_store.dart';
import 'package:vibration/vibration.dart';

import '../../../domain/entity/divided_lecture/divided_lecture.dart';

class DividedLectureItem extends StatelessWidget {
  final DividedLecture currentDividedLecture;
  final void Function() onGoToExercise;
  final LevelStore _levelStore = getIt<LevelStore>();

  DividedLectureItem({
    required this.currentDividedLecture,
    required this.onGoToExercise,
  });

  @override
  Widget build(BuildContext context) {
    String topicName =
        _levelStore.getTopicNameById(currentDividedLecture.topicId);
    String levelName =
        _levelStore.getLevelNameById(currentDividedLecture.levelId);

    return Container(
      margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // boxShadow: [
        //   BoxShadow(
        //     color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
        //     blurRadius: 8,
        //     offset: const Offset(3, 5),
        //   ),
        // ],
      ),
      child: GestureDetector(
        onTap: () async {
          final isGoToExercise =
              await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ContentInDividedLectureScreen(
                currentDividedLecture: currentDividedLecture),
          ));
          if (isGoToExercise != null &&
              isGoToExercise is bool &&
              isGoToExercise) {
            onGoToExercise();
          }
          Vibration.vibrate(duration: 60);
        },
        child: Row(
          children: [
            // Image + completed questions/total questions
            Expanded(
              flex: 1,
              child: Image.asset('assets/images/pdf_image.png',
                  width: 60, height: 60),
            ),
            SizedBox(width: 10),

            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Divided Lecture name
                  Text(
                    currentDividedLecture.dividedLectureName,
                    style: Theme.of(context).textTheme.subTitle.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18),
                  ),
                  const SizedBox(height: 6),
                  // Topic name + level name
                  Text(
                    '$topicName - $levelName',
                    style: Theme.of(context)
                        .textTheme
                        .subTitle
                        .copyWith(color: Colors.orange, fontSize: 14),
                  ),

                  const SizedBox(width: 6),
                ],
              ),
            ),
            const SizedBox(width: 6),
          ],
        ),
      ),
    );
  }
}
