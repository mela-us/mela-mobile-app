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

  double getMaxExcellence() {
    if (excellenceValues.isEmpty) return 0;
    return excellenceValues.reduce((a, b) => a > b ? a : b);
  }

  void sortExcellenceValues() {
    stats.sort((a, b) {
      if (a.excellence > 0 && b.excellence <= 0) return -1;
      if (a.excellence <= 0 && b.excellence > 0) return 1;
      return 0;
    });
  }

  List<double> getPositiveValues() {
    return excellenceValues.where((value) => value > 0).toList();
  }


  Widget build(BuildContext context) {

    sortExcellenceValues();

    topics = stats.map((e) => e.topic).toList();
    excellenceValues = stats.map((e) => e.excellence).toList();
    sides = stats.length;

    final max = getMaxExcellence();

    chartSize = 300;
    labelRadius = chartSize / 2 - 22;

    return SizedBox(
      height: 300,
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
                ticks: max > 20
                    ? const [20, 40, 60, 80, 100]
                    : const [5, 10, 15, 20],
                features: List.filled(sides, ""),
                data: [excellenceValues],
                reverseAxis: false,
                sides: sides,
                ticksTextStyle: Theme.of(context).textTheme.miniCaption.copyWith(
                  color: Colors.white,
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
    final angle = 2 * pi * i / sides - pi / 2;
    final x = labelRadius * cos(angle);
    final y = labelRadius * sin(angle);

    print ("${topics[i]} (${angle})");

    return Transform.translate(
      offset: Offset(x, y),
      child: SizedBox(
        width: 64,
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            trimTopic(topics[i]),
            style:  Theme.of(context).textTheme.subTitle.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 14,
                fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.fade,
            maxLines: 2,
          ),
          _buildAnimatedNumberWithIndex(i),
        ],
      ),
    ));
  }

  Color getColorForScore(double score, BuildContext context) {
    if (score < 50) {
      return Theme.of(context).colorScheme.secondary;
    }
    if (score >= 80) {
      return Colors.green;
    }
    return Theme.of(context).colorScheme.onPrimary;
  }

  String trimTopic(String input) {
    return input.replaceAll('và', '&');
  }

  Widget _buildAnimatedNumberWithIndex(int i) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: excellenceValues[i]),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
      builder: (BuildContext context, double animatedValue, Widget? child) {
        return Text(
          // ép thành số nguyên
          animatedValue.toStringAsFixed(0),
          style: Theme.of(context).textTheme.bigTitle!.copyWith(
            color: getColorForScore(excellenceValues[i], context),
            fontSize: 26,
          ),
        );
      },
    );
  }
}