import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/home_screen/store/level_store/level_store.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../domain/entity/lecture/lecture.dart';

class LectureItemCopy extends StatelessWidget {
  final Lecture lecture;
  final bool isLast;
  final bool isFirst;
  final bool isPursuing;
  final _levelStore = getIt<LevelStore>();
  // final _exerciseStore = getIt<ExerciseStore>();
  // final _searchStore = getIt<SearchStore>();
  // final _filterStore = getIt<FilterStore>();
  LectureItemCopy({
    super.key,
    required this.isLast,
    required this.lecture,
    required this.isFirst,
    required this.isPursuing,
  });

  @override
  Widget build(BuildContext context) {
    String topicName = _levelStore.getTopicNameById(lecture.topicId);
    String levelName = _levelStore.getLevelNameById(lecture.levelId);
    bool isCompleted = lecture.progress == 1.0;
    return GestureDetector(
        onTap: () {
          // _exerciseStore.setCurrentLecture(lecture);
          // //Navigator.of(context).pushNamed(Routes.dividedLecturesAndExercisesScreen);
          // Navigator.of(context).pushNamedAndRemoveUntil(
          //   Routes.dividedLecturesAndExercisesScreen,
          //   (route) {
          //     final routeName = route.settings.name;
          //     //if user at search screen, remove search, filter screen
          //     //if user at lecture in topic screen, not remove this screen
          //     // Return false to remove search and filter screens
          //     // Return true to keep other screens
          //     if(routeName == Routes.searchScreen || routeName == Routes.filterScreen){
          //       _searchStore.resetAllInSearch();
          //       _filterStore.resetFilter();
          //       return false;
          //     }
          //     return true;
          //   },
          // );
        },
        child: TimelineTile(
            isFirst: isFirst,
            isLast: isLast,
            alignment: TimelineAlign.manual,
            lineXY: 0.1,
            indicatorStyle: IndicatorStyle(
              width: 30,
              height: 30,
              drawGap: true,
              indicator: isPursuing
                  ? Icon(
                      Icons.circle,
                      color: Theme.of(context).colorScheme.tertiary,
                      size: 30,
                    )
                  : Icon(
                      isCompleted
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: Theme.of(context).colorScheme.tertiary,
                      size: 30,
                    ),
            ),
            beforeLineStyle: LineStyle(
              color: Theme.of(context).colorScheme.tertiary,
              thickness: 2,
            ),
            afterLineStyle: LineStyle(
              color: Theme.of(context).colorScheme.tertiary,
              thickness: 2,
            ),
            startChild: const SizedBox(height: 120), // để tạo khoảng cách đều
            endChild: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onTertiary,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(3, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    //Title and description of the lecture
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lecture.lectureName,
                            style: Theme.of(context)
                                .textTheme
                                .subTitle
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          ),
                          const SizedBox(height: 8),
                          // Topic name + level name
                          Text(
                            '$topicName - $levelName',
                            style: Theme.of(context)
                                .textTheme
                                .subTitle
                                .copyWith(color: Colors.orange, fontSize: 12),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            lecture.lectureDescription,
                            style: Theme.of(context).textTheme.normal.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
            )));
  }
}
