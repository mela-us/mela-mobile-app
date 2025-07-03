import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/presentation/stats_topic_personal/store/detailed_stats_store.dart';
import 'package:mela/presentation/stats_topic_personal/widgets/radar_stat_chart.dart';

import '../../core/widgets/icon_widget/error_icon_widget.dart';
import '../../core/widgets/image_progress_indicator.dart';
import '../../di/service_locator.dart';
import '../../domain/entity/stat/detailed_stat.dart';

class StatsTopicPersonal extends StatefulWidget {

  const StatsTopicPersonal({
    super.key,
  });

  @override
  _StatsTopicPersonalState createState() =>
      _StatsTopicPersonalState();
}

class _StatsTopicPersonalState extends State<StatsTopicPersonal> {
  final DetailedStatStore _store = getIt<DetailedStatStore>();
  late List<DetailedStat> list;
  late String url;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Observer(
          builder: (context) {
            //
            if (_store.loading) {
              return const Center(child: RotatingImageIndicator());
            }
            if (!_store.success && !_store.loading) {
              return const Center(
                child: ErrorIconWidget(message: "Đã có lỗi xảy ra. Vui lòng thử lại"),
              );
            }
            //
            list = _store.stats?.detailedStats ?? [];
            //
            if (list.isEmpty) {
              return const Center(
                child: ErrorIconWidget(message: "Đã có lỗi xảy ra. Vui lòng thử lại"),
              );
            }
            //
            return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
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
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _store.getStats();
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
