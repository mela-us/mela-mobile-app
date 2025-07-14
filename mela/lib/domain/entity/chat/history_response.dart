import 'package:flutter/foundation.dart';
import 'package:mela/domain/entity/chat/history_item.dart';

class HistoryResponse {
  final String object;
  final DateTime firstUpdateAt;
  final DateTime lastUpdateAt;
  final bool hasMore;
  final List<HistoryItem> data;

  HistoryResponse(
      {required this.object,
      required this.firstUpdateAt,
      required this.lastUpdateAt,
      required this.hasMore,
      required this.data});

  factory HistoryResponse.fromJson(Map<String, dynamic> json) {
    return HistoryResponse(
      object: json['object'],
      data: (json['data'] as List<dynamic>)
          .map((item) => HistoryItem.fromJson(item))
          .toList(),
      firstUpdateAt: DateTime.parse(json['firstUpdatedAt']),
      lastUpdateAt: DateTime.parse(json['lastUpdatedAt']),
      hasMore: json['hasMore'],
    );
  }
}
