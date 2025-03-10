import 'package:flutter/material.dart';
import 'package:mela/domain/entity/stat/progress.dart';

import 'chart_widget.dart';

import '../../../constants/assets.dart';
import '../../../constants/app_theme.dart';
import 'line_chart_widget.dart';


class ExpandableItem extends StatefulWidget {
  final Progress item;

  ExpandableItem({super.key, required this.item});

  @override
  _ExpandableItemState createState() => _ExpandableItemState();
}

class _ExpandableItemState extends State<ExpandableItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      elevation: 5.0,
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
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 150,
                          minWidth: 150,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text( //Tên bài tập
                              'Luyện tập 1',
                              style: Theme.of(context).textTheme.title
                                  .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                            ),
                            Text( //Tên bài học
                              'Bài học 1',
                              style: Theme.of(context).textTheme.normal
                                  .copyWith(color: Theme.of(context).colorScheme.textInBg1),
                            ),
                            Text( //Tên chủ đề
                              '${widget.item.topicName}',
                              style: Theme.of(context).textTheme.normal
                                  .copyWith(color: Theme.of(context).colorScheme.textInBg2),
                            ),
                          ],
                        ),
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(//date
                              '08-03-2025',
                              style: Theme.of(context).textTheme.normal
                                  .copyWith(color: Theme.of(context).colorScheme.textInBg1),
                            ),
                            Text(//score
                              '8.5',
                              style: Theme.of(context).textTheme.bigTitle
                                  .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                            ),
                          ]
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              Assets.stats_gain,
                              width: 21,
                              height: 21,
                            ),
                            const SizedBox(width: 5),
                            Image.asset(
                              _isExpanded ? Assets.stats_hide : Assets.stats_show,
                              width: 16,
                              height: 16,
                            )
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
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 1),
                  LineChartWidget(),
                  SizedBox(height: 8),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
