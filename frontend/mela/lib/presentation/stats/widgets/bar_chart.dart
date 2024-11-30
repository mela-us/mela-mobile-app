import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/domain/entity/stat/detailed_progress.dart';
import '../../../di/service_locator.dart';
import '../../../themes/default/colors_standards.dart';
import '../store/stats_store.dart';
import 'package:intl/intl.dart';

class BarChartWidget extends StatelessWidget {
  final String topicName;
  final String division;
  //
  final StatisticsStore store = getIt<StatisticsStore>();
  //
  BarChartWidget({super.key, required this.topicName, required this.division});

  @override
  Widget build(BuildContext context) {
    List<DetailedProgress>? list = store.detailedProgressList?.detailedProgressList;
    //filter by division and topic name
    List<DetailedProgress>? filteredList = list?.where(
            (progress) => progress.division == division && progress.topicName == topicName
    ).toList();
    //
    DateTime now = DateTime.now();
    DateTime sevenDaysToNow = now.subtract(const Duration(days: 7));
    filteredList = filteredList?.where(
            (progress) {
          final dateString = progress.date;
          if (dateString != null) {
            DateTime itemDate = DateFormat("dd/MM/yyyy").parse(dateString);
            return itemDate.isBefore(now) && itemDate.isAfter(sevenDaysToNow);
          } else {
            return false;
          }
        }
    ).toList();
    return SizedBox(
      height: 150,
      child: Observer(
        builder: (context) {
          if (store.detailedProgressLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return MakeBarChart(filteredList, now);
        },
      ),
    );
  }

  double? countInDate(List<DetailedProgress> list, DateTime time) {
    String dateString = DateFormat('yyyy-MM-dd').format(time);
    return list.firstWhere(
            (progress) => progress.date == dateString,
            orElse: () => DetailedProgress(topicName: "NA", division: "NA", date: "NA", count: 0)).count?.toDouble();
  }

  String dateOfWeekConverter(DateTime time) {
    switch (time.weekday) {
      case 1:
        return 'T2';
      case 2:
        return 'T3';
      case 3:
        return 'T4';
      case 4:
        return 'T5';
      case 5:
        return 'T6';
      case 6:
        return 'T7';
      case 7:
        return 'CN';
      default:
        return '';
    }
  }

  Widget MakeBarChart(List<DetailedProgress>? filteredList, DateTime now) {
    return BarChart(
      BarChartData(
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                fromY: 0,
                toY: countInDate(filteredList!, now.subtract(const Duration(days: 6))) ?? 0,
                color: ColorsStandards.buttonYesColor1,
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                fromY: 0,
                toY: countInDate(filteredList!, now.subtract(const Duration(days: 5))) ?? 0,
                color: ColorsStandards.buttonYesColor1,
              ),
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                fromY: 0,
                toY: countInDate(filteredList!, now.subtract(const Duration(days: 4))) ?? 0,
                color: ColorsStandards.buttonYesColor1,
              ),
            ],
          ),
          BarChartGroupData(
            x: 3,
            barRods: [
              BarChartRodData(
                fromY: 0,
                toY: countInDate(filteredList!, now.subtract(const Duration(days: 3))) ?? 0,
                color: ColorsStandards.buttonYesColor1,
              ),
            ],
          ),
          BarChartGroupData(
            x: 4,
            barRods: [
              BarChartRodData(
                fromY: 0,
                toY: countInDate(filteredList!, now.subtract(const Duration(days: 2))) ?? 0,
                color: ColorsStandards.buttonYesColor1,
              ),
            ],
          ),
          BarChartGroupData(
            x: 5,
            barRods: [
              BarChartRodData(
                fromY: 0,
                toY: countInDate(filteredList!, now.subtract(const Duration(days: 1))) ?? 0,
                color: ColorsStandards.buttonYesColor1,
              ),
            ],
          ),
          BarChartGroupData(
            x: 6,
            barRods: [
              BarChartRodData(
                fromY: 0,
                toY: countInDate(filteredList!, now) ?? 0,
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
                    label = dateOfWeekConverter(now.subtract(const Duration(days: 6)));
                    break;
                  case 1:
                    label = dateOfWeekConverter(now.subtract(const Duration(days: 5)));
                    break;
                  case 2:
                    label = dateOfWeekConverter(now.subtract(const Duration(days: 4)));
                    break;
                  case 3:
                    label = dateOfWeekConverter(now.subtract(const Duration(days: 3)));
                    break;
                  case 4:
                    label = dateOfWeekConverter(now.subtract(const Duration(days: 2)));
                    break;
                  case 5:
                    label = dateOfWeekConverter(now.subtract(const Duration(days: 1)));
                    break;
                  case 6:
                    label = 'Nay';
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
    );
  }
}