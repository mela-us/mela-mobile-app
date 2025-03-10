import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mela/constants/app_theme.dart';

class Result {
  final String date;
  final double score;

  Result({required this.date, required this.score});
}

class LineChartWidget extends StatelessWidget {
  final List<Result> results = [
    Result(date: '04-01-2025', score: 7.5),
    Result(date: '05-01-2025', score: 9.0),
    Result(date: '08-03-2025', score: 8.0),
    Result(date: '08-03-2025', score: 8.5),
  ];

  LineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Padding(
        padding: const EdgeInsets.only(left: 17.0, right: 26.0, top: 16.0, bottom: 19.0),
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 10,
                  interval: 0.5,
                  getTitlesWidget: (value, meta) {
                    if (value >= 0 && value <= 10 && value - value.toInt() == 0) {
                      return Text(
                          value.toInt().toString(),
                          style: Theme.of(context).textTheme.subHeading
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
                  getTitlesWidget: (value, meta) {
                    int index = value.toInt();
                    if (index == 0 || index == results.length - 1) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(results[index].date,
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
              horizontalInterval: 0.25,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey.shade300,
                  strokeWidth: 1,
                );
              },
            ),
            lineBarsData: [
              LineChartBarData(
                spots: results.asMap().entries.map((entry) {
                  int index = entry.key;
                  Result result = entry.value;
                  return FlSpot(index.toDouble(), result.score);
                }).toList(),
                isCurved: true,
                barWidth: 3,
                belowBarData: BarAreaData(show: false),
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 4,
                      color: Colors.blue,
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
                    final result = results[spot.x.toInt()];
                    return LineTooltipItem(
                      '${result.date}\nĐiểm: ${result.score}',
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
}
