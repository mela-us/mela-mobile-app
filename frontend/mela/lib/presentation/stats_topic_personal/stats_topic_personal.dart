import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/presentation/stats_topic_personal/widgets/radar_stat_chart.dart';
import 'package:mela/presentation/stats_topic_personal/widgets/tile_list.dart';

import '../../domain/entity/stat/detailed_stat.dart';

class StatsTopicPersonal extends StatefulWidget {

  const StatsTopicPersonal({
    super.key,
  });

  @override
  _StatsTopicPersonalState createState() =>
      _StatsTopicPersonalState();
}

class _StatsTopicPersonalState
    extends State<StatsTopicPersonal> {
  late List<DetailedStat> list;
  late String url;

  @override
  Widget build(BuildContext context) {
    list = getMock();
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            Observer(
              builder: (context) {
                if (list.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Oops! Hành trình của bạn chưa bắt đầu\nHãy bắt đầu học!',
                            style: Theme.of(context).textTheme.subTitle.copyWith(
                                color: Theme.of(context).colorScheme.textInBg1),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                      children: [
                        const SizedBox(height: 12),
                        RadarStatChart(stats: list),
                        const SizedBox(height: 4),
                      ]
                  ),
                );
                //return TileList(list: list);
              },
            ),
          ],
        ));
  }
}

List<DetailedStat> getMock() {
  return [
    DetailedStat(
      topic: 'Đại số',
      excellence: 82.5,
    ),
    DetailedStat(
      topic: 'Hình học',
      excellence: 68.0,
    ),
    DetailedStat(
      topic: 'Xác suất - Thống kê',
      excellence: 57.0,
    ),
    DetailedStat(
      topic: 'Tư duy',
      excellence: 89.0,
    ),
    DetailedStat(
      topic: 'Số học',
      excellence: 40.5,
    ),
  ];
}
