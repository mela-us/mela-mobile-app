import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/domain/entity/suggestion/suggestion.dart';
import 'package:mela/presentation/content_in_divided_lecture_screen/content_in_divided_lecture_screen.dart';
import 'package:mela/presentation/list_proposed_new_lecture/store/list_proposed_new_suggestion_store.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:vibration/vibration.dart';

class SectionItem extends StatefulWidget {
  final Section section;
  final bool isLast;
  final bool isFirst;

  SectionItem({
    required this.section,
    this.isLast = false,
    this.isFirst = false,
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
          indicator: Icon(
            widget.section.isDone
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            color: widget.section.isDone
                ? Theme.of(context).colorScheme.tertiary
                : Colors.grey,
            size: 30,
          ),
        ),
        beforeLineStyle: LineStyle(
          color: widget.section.isDone
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
        endChild: buildItemSection());
  }

  Widget buildItemSection() {
    String topicName = widget.section.topicTitle;
    String levelName = widget.section.levelTitle;

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
          final isUpdateSuggestion =
              await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ContentInDividedLectureScreen(
              currentDividedLecture: widget.section.toDividedLectureFromSection,
              suggestionId: widget.section.suggestionId,
            ),
          ));
          if (isUpdateSuggestion != null &&
              isUpdateSuggestion is bool &&
              isUpdateSuggestion) {
            _store.getProposedNewLecture();
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
