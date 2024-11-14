import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/domain/entity/divided_lecture/divided_lecture.dart';

class ContentInDividedLectureScreen extends StatelessWidget {
  final DividedLecture currentDividedLecture;
  const ContentInDividedLectureScreen(
      {super.key, required this.currentDividedLecture});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentDividedLecture.dividedLectureName,
          style: Theme.of(context)
              .textTheme
              .heading
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Text(currentDividedLecture.contentInDividedLecture),
      ),
    );
  }
}
