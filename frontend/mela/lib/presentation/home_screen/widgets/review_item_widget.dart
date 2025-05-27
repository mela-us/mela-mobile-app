import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/domain/entity/revise/revise_item.dart';
import 'package:mela/presentation/question/store/question_store.dart';
import 'package:mela/utils/routes/routes.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ReviewItemWidget extends StatelessWidget {
  final ReviseItem reviseItem;

  final bool isLast;
  final bool isFirst;
  final bool isPursuing;
  const ReviewItemWidget(
      {super.key,
      required this.reviseItem,
      required this.isLast,
      required this.isFirst,
      required this.isPursuing});

  @override
  Widget build(BuildContext context) {
    String name = reviseItem.lectureTitle;
    String topicName = reviseItem.topicTitle;
    String levelName = reviseItem.levelTitle;
    String itemType =
        reviseItem.type == ReviewItemType.EXERCISE ? 'Bài tập' : 'Bài giảng';

    final QuestionStore _questionStore = getIt<QuestionStore>();
    return GestureDetector(
        onTap: () {
          if (reviseItem.isDone || isPursuing) {
            //Exercise navigating
            if (reviseItem.type == ReviewItemType.EXERCISE) {
              _questionStore.setQuestionsUid(
                reviseItem.itemId,
              );
              // Navigate to exercise screen
              Navigator.of(context).pushNamed(
                Routes.question,
              );
            }

            //Lecture navigating
            else {}
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Bài học đang khóa',
                    style: Theme.of(context).textTheme.title.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        )),
                content: Text('Hãy hoàn thành bài học trước đó để mở khóa.',
                    style: Theme.of(context).textTheme.normal.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        )),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Đóng',
                      style: Theme.of(context).textTheme.buttonStyle.copyWith(
                            color: Colors.red,
                          ),
                    ),
                  ),
                ],
              ),
            );
          }
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
                      reviseItem.isDone ? Icons.check_circle : Icons.lock,
                      color: reviseItem.isDone
                          ? Theme.of(context).colorScheme.tertiary
                          : Colors.grey,
                      size: 30,
                    ),
            ),
            beforeLineStyle: LineStyle(
              color: reviseItem.isDone || isPursuing
                  ? Theme.of(context).colorScheme.tertiary
                  : Colors.grey,
              thickness: 2,
            ),
            afterLineStyle: LineStyle(
              color: reviseItem.isDone
                  ? Theme.of(context).colorScheme.tertiary
                  : Colors.grey,
              thickness: 2,
            ),
            startChild: const SizedBox(height: 120), // để tạo khoảng cách đều
            endChild: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: reviseItem.isDone || isPursuing
                  ? _buildItemContainer(
                      context, name, topicName, levelName, itemType)
                  : Stack(
                      children: [
                        _buildItemContainer(
                            context, name, topicName, levelName, itemType),
                        //Showing item card
                        //Showing lock icon if the item is not done
                        // and not pursuing
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Icon(Icons.lock,
                              color: Colors.grey.shade700, size: 20),
                        ),
                      ],
                    ),
            )));
  }

  Widget _buildItemContainer(BuildContext context, String name,
      String topicName, String levelName, String itemType) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onTertiary,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(3, 5),
            ),
          ],
        ),
        child: _buildItemCard(context, name, topicName, levelName, itemType));
  }

  Widget _buildItemCard(BuildContext context, String name, String topicName,
      String levelName, String itemType) {
    return Row(
      children: [
        //Title and description of the lecture
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context)
                    .textTheme
                    .subTitle
                    .copyWith(color: Theme.of(context).colorScheme.primary),
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
                itemType,
                style: Theme.of(context).textTheme.normal.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
