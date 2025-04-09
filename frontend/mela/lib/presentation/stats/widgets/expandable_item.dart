import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:mela/domain/entity/stat/progress.dart';

import '../../../constants/assets.dart';
import '../../../constants/app_theme.dart';
import '../../../domain/entity/stat/score_record.dart';
import 'line_chart_widget.dart';


class ExpandableItem extends StatefulWidget {
  final Progress item;

  const ExpandableItem({super.key, required this.item});

  @override
  _ExpandableItemState createState() => _ExpandableItemState();
}

class _ExpandableItemState extends State<ExpandableItem> {
  bool _isExpanded = false;
  late String type;
  late ProgressExercise? progressExercise;
  late ProgressSection? progressSection;
  late List<ScoreRecord> scores;

  @override
  Widget build(BuildContext context) {
    type = widget.item.type;
    progressExercise = widget.item.exercise;
    progressSection = widget.item.section;
    scores = progressExercise?.scoreRecords ?? [];
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      elevation: 5.0,
      color: !_isExpanded ? Colors.white : Theme.of(context).colorScheme.appBackground,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (type != 'SECTION' && scores.length > 1) {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 160,
                          minWidth: 160,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text( //Tên bài tập hoặc section
                              (type == 'SECTION')
                                  ? progressSection?.sectionName ?? ""
                                  : progressExercise?.exerciseName ?? "",
                              style: Theme.of(context).textTheme.title
                                  .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                              maxLines: 1, // Giới hạn 1 dòng
                              overflow: TextOverflow.ellipsis, // Thêm "..." nếu quá dài
                            ),
                            Text( //Tên bài học
                              widget.item.lectureName ?? "",
                              style: Theme.of(context).textTheme.normal
                                  .copyWith(color: Theme.of(context).colorScheme.textInBg1),
                              maxLines: (_isExpanded) ? 2 : 1, // Giới hạn 1 dòng
                              overflow: (_isExpanded) ? TextOverflow.visible : TextOverflow.ellipsis, // Thêm "..." nếu quá dài
                            ),
                            Text( //Tên chủ đề
                              widget.item.topicName ?? "",
                              style: Theme.of(context).textTheme.normal
                                  .copyWith(color: Theme.of(context).colorScheme.textInBg2),
                            ),
                          ],
                        ),
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(//học bài hay làm bài?
                              (type == 'SECTION') ? "Đã học" : "Đã làm bài",
                              style: Theme.of(context).textTheme.normal
                                  .copyWith(color: Theme.of(context).colorScheme.tertiary),
                            ),
                            Text(//date
                              parseDate(widget.item.latestDate),
                              style: Theme.of(context).textTheme.normal
                                  .copyWith(color: Theme.of(context).colorScheme.textInBg1),
                            ),
                            if (type != 'SECTION' && (widget.item.exercise?.latestScore ?? 0) < 50)
                              Text(//score
                                "${(widget.item.exercise?.latestScore ?? 0)} Điểm",
                                style:  Theme.of(context).textTheme.bigTitle
                                    .copyWith(
                                    color:  Colors.red
                                ),
                              )
                            else if (type != 'SECTION' && (widget.item.exercise?.latestScore ?? 0) >= 80)
                              Text(//score
                                "${(widget.item.exercise?.latestScore ?? 0)} Điểm",
                                style:  Theme.of(context).textTheme.bigTitle
                                    .copyWith(
                                    color:  Colors.green
                                ),
                              )
                            else if (type != 'SECTION')
                              Text(//score
                                "${(widget.item.exercise?.latestScore ?? 0)} Điểm",
                                style:  Theme.of(context).textTheme.bigTitle
                                    .copyWith(
                                    color:  Theme.of(context).colorScheme.onPrimary
                                ),
                              ),
                          ]
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (type != 'SECTION' && scores.length > 1 && scores[0].score > scores[1].score)
                              Image.asset(
                                Assets.stats_gain,
                                width: 21,
                                height: 21,
                              )
                            else if (type != 'SECTION' && scores.length > 1 && scores[0].score < scores[1].score)
                              Image.asset(
                                Assets.stats_drop,
                                width: 21,
                                height: 21,
                              )
                            else const SizedBox(width: 21, height: 21),
                            const SizedBox(width: 5),
                            if (type != 'SECTION' && scores.length > 1)
                              Image.asset(
                                _isExpanded ? Assets.stats_hide : Assets.stats_show,
                                width: 16,
                                height: 16,
                              )
                            else const SizedBox(width: 16, height: 16),
                          ]
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 1),
                  LineChartWidget(scores: scores)
                    .animate()
                      .fadeIn(
                        duration: 0.8.seconds,
                        curve: Curves.easeIn,
                      ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
        ],
      ),
    );
  }
  String parseDate(String inputDate) {
    DateTime parsedDate = DateTime.parse(inputDate);
    return  DateFormat('dd-MM-yyyy').format(parsedDate);
  }
}
