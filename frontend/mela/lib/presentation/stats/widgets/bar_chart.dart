import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../themes/default/colors_standards.dart';
import '../../../themes/default/text_styles.dart';

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: BarChart(
        BarChartData(
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(
                  fromY: 0,
                  toY: 0,
                  color: ColorsStandards.buttonYesColor1,
                ),
              ],
            ),
            BarChartGroupData(
              x: 1,
              barRods: [
                BarChartRodData(
                  fromY: 0,
                  toY: 1,
                  color: ColorsStandards.buttonYesColor1,
                ),
              ],
            ),
            BarChartGroupData(
              x: 2,
              barRods: [
                BarChartRodData(
                  fromY: 0,
                  toY: 2,
                  color: ColorsStandards.buttonYesColor1,
                ),
              ],
            ),
            BarChartGroupData(
              x: 3,
              barRods: [
                BarChartRodData(
                  fromY: 0,
                  toY: 0,
                  color: ColorsStandards.buttonYesColor1,
                ),
              ],
            ),
            BarChartGroupData(
              x: 4,
              barRods: [
                BarChartRodData(
                  fromY: 0,
                  toY: 2,
                  color: ColorsStandards.buttonYesColor1,
                ),
              ],
            ),
            BarChartGroupData(
              x: 5,
              barRods: [
                BarChartRodData(
                  fromY: 0,
                  toY: 1,
                  color: ColorsStandards.buttonYesColor1,
                ),
              ],
            ),
            BarChartGroupData(
              x: 6,
              barRods: [
                BarChartRodData(
                  fromY: 0,
                  toY: 1,
                  color: ColorsStandards.buttonYesColor1,
                ),
              ],
            ),
          ],
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  String label;
                  switch (value.toInt()) {
                    case 0:
                      label = '2';
                      break;
                    case 1:
                      label = '3';
                      break;
                    case 2:
                      label = '4';
                      break;
                    case 3:
                      label = '5';
                      break;
                    case 4:
                      label = '6';
                      break;
                    case 5:
                      label = '7';
                      break;
                    case 6:
                      label = 'CN';
                      break;
                    default:
                      label = '';
                  }
                  return Text(label);
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  String label;
                  if (value == 0) {
                    label = '0';
                  } else if (value == 1) {
                    label = '1';
                  } else if (value == 2) {
                    label = '2';
                  } else if (value == 3) {
                    label = '3';
                  } else if (value == 4) {
                    label = '4';
                  } else if (value == 5) {
                    label = '5';
                  } else {
                    label = '';
                  }
                  return Text(label);
                },
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false), // Ẩn nhãn trên cùng
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false), // Ẩn nhãn bên phải
            ),
          ),
          maxY: 5, // Đặt giá trị tối đa cho cột y
          gridData: const FlGridData(show: true, drawHorizontalLine: true, horizontalInterval: 1),
        ),
      ),
    );
  }
}