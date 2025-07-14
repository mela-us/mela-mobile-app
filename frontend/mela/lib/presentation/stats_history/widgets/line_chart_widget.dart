import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:mela/constants/app_theme.dart';

import '../../../domain/entity/stat/score_record.dart';


class LineChartWidget extends StatelessWidget {
  final List<ScoreRecord> scores;

  late double highest, lowest, median;

  LineChartWidget({super.key, required this.scores});

  @override
  Widget build(BuildContext context) {
    //
    final reversedScore = scores.reversed.toList();
    //
    List<double> sortedScores = reversedScore.map((e) => e.score).toList()..sort();
    int mid = sortedScores.length ~/ 2;
    if (sortedScores.length % 2 == 1) {
      median = sortedScores[mid];
    } else {
      median = (sortedScores[mid - 1] + sortedScores[mid]) / 2;
    }

    highest = sortedScores.last;
    lowest = sortedScores.first;
    //
    return AspectRatio(
      aspectRatio: 1.5,
      child: Padding(
        padding: const EdgeInsets.only(left: 17.0, right: 26.0, top: 16.0, bottom: 19.0),
        child: LineChart(
          LineChartData(
            minY: (lowest == highest) ? 0 : null,
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
                    if (value == highest || value == median || value == lowest) {
                      if (value < 50) {
                        return Text(
                          double.parse(value.toStringAsFixed(1)).toString(),
                          style: Theme.of(context).textTheme.miniCaption
                              .copyWith(color: Colors.red),
                          textAlign: TextAlign.left,
                        );
                      } else if (value >= 80) {
                        return Text(
                          double.parse(value.toStringAsFixed(1)).toString(),
                          style: Theme.of(context).textTheme.miniCaption
                              .copyWith(color: Colors.green),
                          textAlign: TextAlign.left,
                        );
                      }
                      else {
                        return Text(
                          double.parse(value.toStringAsFixed(1)).toString(),
                          style: Theme.of(context).textTheme.miniCaption
                              .copyWith(color: Theme.of(context).colorScheme.textInBg1),
                          textAlign: TextAlign.left,
                        );
                      }
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
                    if (index == 0 || index == reversedScore.length - 1) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          parseDate(reversedScore[index].date),
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
              horizontalInterval: 5,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey.shade300,
                  strokeWidth: 1,
                );
              },
            ),
            lineBarsData: [
              LineChartBarData(
                spots: reversedScore.asMap().entries.map((entry) {
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
                    final result = reversedScore[spot.x.toInt()];
                    return LineTooltipItem(
                      '${parseDate(result.date)}\nĐiểm: ${double.parse(result.score.toStringAsFixed(1))}',
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
