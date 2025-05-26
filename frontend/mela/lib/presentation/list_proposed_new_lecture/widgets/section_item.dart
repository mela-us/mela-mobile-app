import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/domain/entity/suggestion/suggestion.dart';
import 'package:mela/presentation/content_in_divided_lecture_screen/content_in_divided_lecture_screen.dart';
import 'package:vibration/vibration.dart';


class SectionItem extends StatelessWidget {
  final Section section;

  SectionItem({
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    String topicName = section.topicTitle;
    String levelName = section.levelTitle;

    return Container(
      margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(3, 5),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ContentInDividedLectureScreen(
                currentDividedLecture: section.toDividedLectureFromSection),
          ));

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
                    section.lectureTitle,
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
