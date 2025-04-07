import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:mela/constants/app_theme.dart';

import '../../../domain/entity/stat/score_record.dart';


class LineChartWidget extends StatelessWidget {
  final List<ScoreRecord> scores;

  final test_scores = [
    ScoreRecord(date: '05-01-2025', score: 9.0),
    ScoreRecord(date: '04-01-2025', score: 7.5),
    ScoreRecord(date: '08-03-2025', score: 8.0),
    ScoreRecord(date: '08-03-2025', score: 8.5),
  ];

  LineChartWidget({super.key, required this.scores});

  @override
  Widget build(BuildContext context) {
    //
    final _scores = scores.reversed.toList();
    //
    return AspectRatio(
      aspectRatio: 1.5,
      child: Padding(
        padding: const EdgeInsets.only(left: 17.0, right: 26.0, top: 16.0, bottom: 19.0),
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                axisNameWidget: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Điểm',
                    style: Theme.of(context).textTheme.miniCaption.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.textInBg1,
                    ),
                  ),
                ),
                axisNameSize: 20,
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  getTitlesWidget: (value, meta) {
                    List<double> sortedScores = _scores.map((e) => e.score).toList()..sort();
                    double median;
                    int mid = sortedScores.length ~/ 2;
                    if (sortedScores.length % 2 == 1) {
                      median = sortedScores[mid];
                    } else {
                      median = (sortedScores[mid - 1] + sortedScores[mid]) / 2;
                    }

                    double highest = sortedScores.last;
                    double lowest = sortedScores.first;

                    if (value == highest || value == median || value == lowest) {
                      return Text(
                        value.toString(),
                        style: Theme.of(context).textTheme.miniCaption
                            .copyWith(color: Theme.of(context).colorScheme.textInBg1),
                        textAlign: TextAlign.left,
                      );
                    }
                    return Container();
                  },
                ),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  reservedSize: 20,
                  getTitlesWidget: (value, meta) {
                    int index = value.toInt();
                    if (index == 0 || index == _scores.length - 1) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          parseDate(_scores[index].date),
                          style: Theme.of(context).textTheme.miniCaption
                              .copyWith(color: Theme.of(context).colorScheme.textInBg1),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            gridData: FlGridData(
              drawVerticalLine: false,
              drawHorizontalLine: true,
              horizontalInterval: 2.5,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey.shade300,
                  strokeWidth: 1,
                );
              },
            ),
            lineBarsData: [
              LineChartBarData(
                spots: _scores.asMap().entries.map((entry) {
                  int index = entry.key;
                  ScoreRecord result = entry.value;
                  return FlSpot(index.toDouble(), result.score);
                }).toList(),
                isCurved: true,
                curveSmoothness: 0.2,
                barWidth: 3,
                belowBarData: BarAreaData(show: false),
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 4,
                      color: Theme.of(context).colorScheme.tertiary,
                      strokeColor: Colors.white,
                    );
                  },
                ),
              ),
            ],
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                getTooltipItems: (List<LineBarSpot> touchedSpots) {
                  return touchedSpots.map((spot) {
                    final result = _scores[spot.x.toInt()];
                    return LineTooltipItem(
                      '${parseDate(result.date)}\nĐiểm: ${result.score}',
                      Theme.of(context).textTheme.miniCaption
                          .copyWith(color: Colors.white),
                    );
                  }).toList();
                },
              ),
              touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {},
              handleBuiltInTouches: true,
            ),
          ),
        ),
      ),
    );
  }

  String parseDate(String inputDate) {
    DateTime parsedDate = DateTime.parse(inputDate);
    return  DateFormat('dd-MM-yyyy').format(parsedDate);
  }
}
