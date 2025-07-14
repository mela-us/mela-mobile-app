class HistoryItem {
  final String conversationId;
  final String title;
  final Metadata metadata;

  HistoryItem(
      {required this.conversationId,
      required this.title,
      required this.metadata});

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      conversationId: json['conversationId'],
      title: json['title'],
      metadata: Metadata.fromJson(json['metadata']),
    );
  }
}

class Metadata {
  final String status;
  final DateTime createdAt;

  Metadata({
    required this.status,
    required this.createdAt,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
