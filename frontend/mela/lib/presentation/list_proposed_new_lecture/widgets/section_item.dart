import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/domain/entity/suggestion/suggestion.dart';
import 'package:mela/presentation/content_in_divided_lecture_screen/content_in_divided_lecture_screen.dart';
import 'package:mela/presentation/list_proposed_new_lecture/store/list_proposed_new_suggestion_store.dart';
import 'package:timeline_tile/timeline_tile.dart';

class SectionItem extends StatefulWidget {
  final Section section;
  final bool isLast;
  final bool isFirst;
  final bool isPursuing; //đang học

  SectionItem({
    required this.section,
    this.isLast = false,
    this.isFirst = false,
    this.isPursuing = false,
  });

  @override
  State<SectionItem> createState() => _SectionItemState();
}

class _SectionItemState extends State<SectionItem> {
  final ListProposedNewSuggestionStore _store =
      getIt.get<ListProposedNewSuggestionStore>();

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
        isFirst: widget.isFirst,
        isLast: widget.isLast,
        alignment: TimelineAlign.manual,
        lineXY: 0.1,
        indicatorStyle: IndicatorStyle(
          width: 30,
          height: 30,
          drawGap: true,
          indicator: widget.isPursuing
              ? Icon(
                  Icons.circle,
                  color: Theme.of(context).colorScheme.tertiary,
                  size: 30,
                )
              : Icon(
                  widget.section.isDone ? Icons.check_circle : Icons.lock,
                  color: widget.section.isDone
                      ? Theme.of(context).colorScheme.tertiary
                      : Colors.grey,
                  size: 30,
                ),
        ),
        beforeLineStyle: LineStyle(
          color: widget.section.isDone || widget.isPursuing
              ? Theme.of(context).colorScheme.tertiary
              : Colors.grey,
          thickness: 2,
        ),
        afterLineStyle: LineStyle(
          color: widget.section.isDone
              ? Theme.of(context).colorScheme.tertiary
              : Colors.grey,
          thickness: 2,
        ),
        startChild: const SizedBox(height: 120),
        endChild: GestureDetector(
          onTap: () async {
            if (widget.section.isDone || widget.isPursuing) {
              final isUpdateSuggestion =
                  await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ContentInDividedLectureScreen(
                  currentDividedLecture:
                      widget.section.toDividedLectureFromSection,
                  suggestionId: widget.section.suggestionId,
                ),
              ));
              if (isUpdateSuggestion != null &&
                  isUpdateSuggestion is bool &&
                  isUpdateSuggestion) {
                _store.getProposedNewLecture();
              } else {
                print('isUpdateSuggestion is null or not a bool');
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                          borderRadius:
                                              BorderRadius.circular(16),
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget.section.isDone || widget.isPursuing
                ? buildItemSection()
                : Stack(
                    children: [
                      buildItemSection(),
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
          ),
        ));
  }

  Widget buildItemSection() {
    String topicName = widget.section.topicTitle;
    String levelName = widget.section.levelTitle;

    return Container(
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
      child: Row(
        children: [
          // Image + completed questions/total questions
          Expanded(
            flex: 1,
            child: Image.asset('assets/images/pdf_image.png',
                width: 50, height: 50),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Divided Lecture name
                Text(
                  widget.section.lectureTitle,
                  style: Theme.of(context).textTheme.subTitle.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16),
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
    );
  }
}
