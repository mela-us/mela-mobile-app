import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/domain/entity/stat/detailed_stat.dart';
import 'package:flutter/material.dart';

import 'expandable_tile.dart';
import 'radar_stat_chart.dart'; // Nhớ import

class TileList extends StatelessWidget {
  final List<DetailedStat>? list;

  const TileList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return ListView.builder(
          itemCount: list!.length + 1,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                children: [
                  RadarStatChart(stats: list!), // Chart ở đầu
                  const SizedBox(height: 4),
                ],
              );
            }

            final stat = list![index - 1];
            return Column(
              children: [
                ExpandableTile(detailedStat: stat),
                const SizedBox(height: 3),
              ],
            );
          },
        );
      },
    );
  }
}
