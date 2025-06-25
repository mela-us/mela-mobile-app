import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:mela/constants/app_theme.dart';

import '../../../domain/entity/stat/detailed_stat.dart';

class RadarStatChart extends StatelessWidget {
  final List<DetailedStat> stats;

  RadarStatChart({Key? key, required this.stats}) : super(key: key);

  late double chartSize;
  late double labelRadius;
  late int sides;
  late List<String> topics;
  late List<double> excellenceValues;


  Widget build(BuildContext context) {
    topics = stats.map((e) => e.topic).toList();
    excellenceValues = stats.map((e) => e.excellence).toList();

    chartSize = 200;
    labelRadius = chartSize / 2 + 21;
    sides = stats.length;

    return SizedBox(
      height: 350,
      width: 250,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Biểu đồ radar
          Center(
            child: SizedBox(
              height: chartSize,
              width: chartSize,
              child: RadarChart(
                ticks: const [20, 40, 60, 80, 100],
                features: List.filled(sides, ""),
                data: [excellenceValues],
                reverseAxis: false,
                sides: sides,
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

          // Các nhãn ở từng đỉnh
          for (int i = 0; i < sides; i++)
            _buildLabel(i,context),
        ],
      ),
    );
  }

  Widget _buildLabel(int i, BuildContext context) {
    return Transform.translate(
      offset: Offset(
        labelRadius * cos(2 * pi * i / sides - pi / 2),
        labelRadius * sin(2 * pi * i / sides - pi / 2),
      ),
      child: Container(
        width: 80,
        height: 70,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.appBackground,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.tertiary,
              blurRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              topics[i],
              style:  Theme.of(context).textTheme.subTitle
                  .copyWith(
                  color:  Theme.of(context).colorScheme.tertiary
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              excellenceValues[i].toStringAsFixed(0),
              style:  Theme.of(context).textTheme.bigTitle
                  .copyWith(
                  color:  getColorForScore(excellenceValues[i],context)
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getColorForScore(double score, BuildContext context) {
    if (score < 50) {
      return Colors.red;
    }
    if (score >= 80) {
      return Colors.green;
    }
    return Theme.of(context).colorScheme.onPrimary;
  }
}