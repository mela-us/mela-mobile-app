import 'package:flutter/material.dart';
import 'package:mela/models/lecture.dart';
import 'package:mela/screens/divided_lectures_and_exercises_screen/divided_lectures_and_exercises_screen.dart';
import 'package:mela/themes/default/text_styles.dart';

import '../../../constants/global.dart';
import '../../../themes/default/colors_standards.dart';

class LectureItem extends StatelessWidget {
  final Lecture lecture;

  const LectureItem({
    Key? key,
    required this.lecture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DividedLecturesAndExercisesScreen(currentLecture: lecture,)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ColorsStandards.buttonYesColor2,
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
                      color: ColorsStandards.buttonYesColor1,
                      backgroundColor: Colors.grey[200],
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 16,
                    child: TextStandard.Normal(lecture.lectureId.toString(),
                        ColorsStandards.textColorInBackground2),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              //Title and description of the lecture
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextStandard.SubTitle(lecture.lectureName,
                        ColorsStandards.textColorInBackground1),
                    const SizedBox(height: 8),
                    TextStandard.Normal(lecture.lectureDescription,
                        ColorsStandards.textColorInBackground2),
                  ],
                ),
              ),
              const SizedBox(width: 16),

              //Button to play the lecture
              Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorsStandards.buttonYesColor1,
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    size: 20,
                    color: ColorsStandards.buttonYesColor2,
                  )), // Play icon
            ],
          ),
        ),
      ),
    );
  }
}
