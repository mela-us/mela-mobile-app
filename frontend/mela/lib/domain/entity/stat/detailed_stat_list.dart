import 'detailed_stat.dart';

class DetailedStatList {
  final List<DetailedStat> detailedStats;

  DetailedStatList({required this.detailedStats});

  factory DetailedStatList.fromJson(Map<String, dynamic> json) {
    return DetailedStatList(
      detailedStats: (json['detailedStats'] as List)
          .map((e) => DetailedStat.fromJson(e))
          .toList(),
    );
  }
}
