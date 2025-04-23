import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:mela/constants/app_theme.dart';

import '../../../domain/entity/stat/detailed_stat.dart';

class RadarStatChart extends StatelessWidget {
  final List<DetailedStat> stats;

  const RadarStatChart({Key? key, required this.stats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topics = stats.map((e) => e.topic).toList();
    final excellenceValues = stats.map((e) => e.excellence).toList();

    return SizedBox(
      height: 240,
      width: 240,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 180,
              width: 180,
              child: RadarChart(
                ticks: const [20, 40, 60, 80, 100],
                features: List.filled(stats.length, ""), // Ẩn text gốc
                data: [excellenceValues],
                reverseAxis: false,
                sides: stats.length,
                ticksTextStyle: Theme.of(context).textTheme.miniCaption.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 9,
                ),
                outlineColor: Theme.of(context).colorScheme.tertiary,
                axisColor: Colors.lightBlueAccent,
                graphColors: [Theme.of(context).colorScheme.tertiary],
              ),
            ),
          ),
          ..._buildCustomLabels(
            topics,
            80, // Bán kính
            Theme.of(context).textTheme.miniCaption.copyWith(
              color: Theme.of(context).colorScheme.tertiary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCustomLabels(List<String> labels, double radius, TextStyle style) {
    final angle = 2 * pi / labels.length;
    return List.generate(labels.length, (i) {
      final x = radius * cos(angle * i - pi / 2);
      final y = radius * sin(angle * i - pi / 2);
      return Positioned(
        left: getLeft(x,style), // Canh giữa theo chiều ngang
        top: getTop(y,style), // Canh giữa theo chiều dọc
        child: Container(
          width: 80, // Điều chỉnh chiều rộng nếu cần
          child: Text(
            labels[i],
            textAlign: x < 0 ? TextAlign.right : TextAlign.left,
            style: style,
            overflow: TextOverflow.visible,
          ),
        ),
      );
    });
  }

  double getLeft(double x, TextStyle style) {
    final temp = (120 + x) - (style.fontSize! / 2);
    if (x < 0) return temp - 68;
    return temp - 1;
  }

  double getTop(double y, TextStyle style) {
    final temp = (120 + y) - (style.fontSize! / 2);
    if (y < 0) return temp - 5;
    return temp;
  }
}