// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:mela/constants/app_theme.dart';
// import 'package:mela/domain/entity/stat/detailed_progress.dart';
// import '../../../di/service_locator.dart';
// import '../../../domain/entity/stat/progress.dart';
// import '../../../domain/entity/level/level.dart';
// import '../../../themes/default/colors_standards.dart';
// import '../../../utils/routes/routes.dart';
// import '../../home_screen/store/level_store/level_store.dart';
// import '../../topic_lecture_in_level_screen/store/topic_lecture_store.dart';
// import '../store/stats_store.dart';
// import 'package:intl/intl.dart';
//
// class ChartWidget extends StatelessWidget {
//   final Progress item;
//   final StatisticsStore store = getIt<StatisticsStore>();
//
//   //call to navigate to level
//   final TopicLectureStore _topicLectureStore = getIt<TopicLectureStore>();
//   final LevelStore _levelStore = getIt<LevelStore>();
//
//   ChartWidget({super.key, required this.item});
//
//   int getMax() {
//     List<DetailedProgress>? list = item.last7Days?.detailedProgressList ?? [];
//     List<int?> stats = list.map((item) => item.count).toList();
//     int? temp = stats.reduce((a, b) => a! > b! ? a : b) ?? 0;
//     return temp > 5 ? temp : 5;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     //
//     Level level = Level(levelId: item.levelId ?? "", levelName: item.levelName ?? "", levelImagePath: "");
//     //
//     List<DetailedProgress>? list = item.last7Days?.detailedProgressList;
//     DateTime now = DateTime.now();
//     DateTime sevenDaysToNow = now.subtract(const Duration(days: 7));
//     List<DetailedProgress>? filteredList = list?.where((progress) {
//       final dateString = progress.date;
//       if (dateString != null) {
//         DateTime itemDate = DateFormat("yyyy-MM-dd").parse(dateString);
//         return itemDate.isBefore(now) && itemDate.isAfter(sevenDaysToNow);
//       }
//       return false;
//     }).toList();
//
//     if (filteredList == null || filteredList!.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               'Oops! 7 ngày rồi bạn không làm\nchủ đề này. Học tiếp nhé!',
//               style: Theme.of(context).textTheme.subTitle
//                   .copyWith(color: Theme.of(context).colorScheme.textInBg1),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 10), // Khoảng cách giữa dòng chữ và nút
//             ElevatedButton(
//               onPressed: () {
//                 _topicLectureStore.setCurrentLevel(level);
//                 _levelStore.resetErrorString();
//                 Navigator.of(context).pushNamed(Routes.topicLectureInLevelScreen);
//               }, //Navigation to Topic
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Theme.of(context).colorScheme.tertiary,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30.0),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 6.0),
//                 child: Text(
//                   'Đi nào!',
//                   style: Theme.of(context).textTheme.subHeading.copyWith(color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//     return SizedBox(
//       height: 200,
//       child: MakeBarChart(filteredList, now, context)
//     );
//   }
//
//   double? countInDate(List<DetailedProgress> list, DateTime time) {
//     String dateString = DateFormat('yyyy-MM-dd').format(time);
//     return list.firstWhere(
//           (progress) => progress.date == dateString,
//       orElse: () => DetailedProgress(date: "NA", count: 0, correctCount: 0),
//     ).count?.toDouble();
//   }
//
//   String dateOfWeekConverter(DateTime time) {
//     switch (time.weekday) {
//       case 1:
//         return 'T2';
//       case 2:
//         return 'T3';
//       case 3:
//         return 'T4';
//       case 4:
//         return 'T5';
//       case 5:
//         return 'T6';
//       case 6:
//         return 'T7';
//       case 7:
//         return 'CN';
//       default:
//         return '';
//     }
//   }
//
//   Widget MakeBarChart(List<DetailedProgress>? filteredList, DateTime now, BuildContext context) {
//     return BarChart(
//       BarChartData(
//         barGroups: List.generate(7, (index) {
//           DateTime day = now.subtract(Duration(days: 6 - index));
//           double count = countInDate(filteredList ?? [], day) ?? 0;
//
//           return BarChartGroupData(
//             x: index,
//             barRods: [
//               BarChartRodData(
//                 fromY: 0,
//                 toY: count,
//                 width: 28,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(14),
//                   topRight: Radius.circular(14),
//                 ),
//                 color: index == 6
//                     ? ColorsStandards.buttonYesColor1
//                     : Colors.grey[400],
//               ),
//             ],
//             showingTooltipIndicators: count > 0 ? [0] : [],
//           );
//         }),
//         titlesData: FlTitlesData(
//           show: true,
//           bottomTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               reservedSize: 40,
//               getTitlesWidget: (value, meta) {
//                 String label;
//                 switch (value.toInt()) {
//                   case 0:
//                     label = dateOfWeekConverter(now.subtract(const Duration(days: 6)));
//                     break;
//                   case 1:
//                     label = dateOfWeekConverter(now.subtract(const Duration(days: 5)));
//                     break;
//                   case 2:
//                     label = dateOfWeekConverter(now.subtract(const Duration(days: 4)));
//                     break;
//                   case 3:
//                     label = dateOfWeekConverter(now.subtract(const Duration(days: 3)));
//                     break;
//                   case 4:
//                     label = dateOfWeekConverter(now.subtract(const Duration(days: 2)));
//                     break;
//                   case 5:
//                     label = dateOfWeekConverter(now.subtract(const Duration(days: 1)));
//                     break;
//                   case 6:
//                     label = 'Nay';
//                     break;
//                   default:
//                     label = '';
//                 }
//                 return Text(
//                   label,
//                   style: Theme.of(context).textTheme.subTitle
//                       .copyWith(color: Theme.of(context).colorScheme.textInBg2),
//                 );
//               },
//             ),
//           ),
//           leftTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               interval: 2,
//               getTitlesWidget: (value, meta) => Center(
//                 child: Text(
//                   value.toInt().toString(),
//                   style: TextStyle(color: Colors.grey[400]),
//                 ),
//               ),
//             ),
//           ),
//           topTitles: AxisTitles(
//             sideTitles: SideTitles(showTitles: false),
//           ),
//           rightTitles: AxisTitles(
//             sideTitles: SideTitles(showTitles: false),
//           ),
//         ),
//         maxY: getMax() + 2.0,
//         gridData: FlGridData(
//           show: true,
//           drawHorizontalLine: true,
//           horizontalInterval: 2,
//           getDrawingHorizontalLine: (value) => FlLine(
//             color: Colors.grey[200],
//             strokeWidth: 1,
//           ),
//           drawVerticalLine: false,
//         ),
//         borderData: FlBorderData(show: false),
//         barTouchData: BarTouchData(
//           enabled: true,
//           touchTooltipData: BarTouchTooltipData(
//             getTooltipColor: (groupIndex) => Colors.transparent,
//             tooltipMargin: 1,
//             tooltipPadding: EdgeInsets.zero,
//             tooltipBorder: BorderSide.none,
//             getTooltipItem: (group, groupIndex, rod, rodIndex) {
//               if (rod.toY == 0) {
//                 return null;
//               }
//               return BarTooltipItem(
//                 rod.toY.toStringAsFixed(0),
//                 const TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 12,
//                 ),
//               );
//             },
//           ),
//         ),
//         extraLinesData: ExtraLinesData(
//           horizontalLines: [
//             HorizontalLine(
//               y: 0,
//               color: Colors.grey[200],
//               strokeWidth: 1,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
