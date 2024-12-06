import 'package:flutter/material.dart';
import 'package:mela/domain/entity/stat/progress.dart';

import '../../../di/service_locator.dart';
import '../store/stats_store.dart';

import 'bar_chart.dart';

import '../../../constants/assets.dart';
import '../../../constants/app_theme.dart';


class ExpandableItem extends StatefulWidget {
  final Progress item;

  final StatisticsStore store = getIt<StatisticsStore>();

  ExpandableItem({super.key, required this.item});

  @override
  _ExpandableItemState createState() => _ExpandableItemState();
}

class _ExpandableItemState extends State<ExpandableItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      color: !_isExpanded ? Colors.white : Theme.of(context).colorScheme.appBackground,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.item.topicName} ${widget.item.totalCorrect!}/${widget.item.total!}',
                        style: Theme.of(context).textTheme.normal
                            .copyWith(color: Colors.black),
                      ),
                      Image.asset(
                        _isExpanded ? Assets.stats_hide : Assets.stats_show,
                        width: 18,
                        height: 18,
                      )
                    ],
                  ),
                  const SizedBox(height: 3),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 1.0),
                    child: LinearProgressIndicator(
                      minHeight: 12,
                      value: widget.item.totalCorrect! * 1.0 / widget.item.total!,
                      color: Theme.of(context).colorScheme.buttonYesBgOrText,
                      backgroundColor: Theme.of(context).colorScheme.textInBg1.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded)
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 8),
                  Text(
                    'Bài tập đã hoàn thành (7 ngày gần đây)',
                    style: Theme.of(context).textTheme.subTitle
                        .copyWith(color: Theme.of(context).colorScheme.textInBg1),
                  ),
                  SizedBox(height: 8),
                  BarChartWidget(item: widget.item),
                  SizedBox(height: 8),
                ],
              ),
            ),
        ],
      ),
    );
  }
}