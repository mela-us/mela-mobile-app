import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/domain/entity/divided_lecture/divided_lecture.dart';
import 'package:mela/domain/entity/revise/revise_item.dart';
import 'package:mela/presentation/content_in_divided_lecture_screen/content_in_divided_lecture_screen.dart';
import 'package:mela/presentation/home_screen/store/revise_store/revise_store.dart';
import 'package:mela/presentation/question/store/question_store.dart';
import 'package:mela/utils/routes/routes.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:vibration/vibration.dart';

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

    final QuestionStore questionStore = getIt<QuestionStore>();
    final ReviseStore reviseStore = getIt<ReviseStore>();
    return GestureDetector(
        onTap: () async {
          if (reviseItem.isDone || isPursuing) {
            reviseStore.setSelectedItem(reviseItem);
            //Exercise navigating
            if (reviseItem.type == ReviewItemType.EXERCISE) {
              questionStore.setQuestionsUid(
                reviseItem.itemId,
              );
              // Navigate to exercise screen
              Navigator.of(context).pushNamed(
                Routes.question,
              );
            }

            //Lecture navigating
            else {
              //Here
              DividedLecture lecture = DividedLecture(
                  ordinalNumber: reviseItem.ordinalNumber,
                  dividedLectureName: reviseItem.lectureTitle,
                  lectureId: reviseItem.itemId,
                  topicId: reviseItem.topicTitle,
                  levelId: reviseItem.levelTitle,
                  contentInDividedLecture: "no content",
                  urlContentInDividedLecture: reviseItem.sectionUrl ?? '',
                  sectionType: "PDF");

              // final isGoToExercise =
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ContentInDividedLectureScreen(
                    currentDividedLecture: lecture),
              ));
              Vibration.vibrate(duration: 60);
            }
          } else {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return Center(
                  child: TapRegion(
                    onTapOutside: (event) {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Title
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.tertiary,
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16)),
                            ),
                            width: double.infinity,
                            child: Text(
                              'Bài học đang khóa',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          // Description
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 24),
                            child: Text(
                              'Hãy hoàn thành bài học trước đó để mở khóa.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          // Buttons
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: Text(
                                      'Đóng',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onTertiary),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
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
          // boxShadow: [
          //   BoxShadow(
          //     color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          //     blurRadius: 6,
          //     offset: const Offset(3, 5),
          //   ),
          // ],
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
