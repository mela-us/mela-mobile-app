class DetailedStat {
  String topic;
  double excellence;

  DetailedStat({
    required this.topic,
    required this.excellence,
  });

  factory DetailedStat.fromJson(Map<String, dynamic> json) {
    return DetailedStat(
      topic: json['topicName'] as String,
      excellence: (json['points'] as num).toDouble(),
    );
  }
}