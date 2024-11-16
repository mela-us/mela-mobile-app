class DetailedProgress{
  String? topicName;
  String? division;
  String? date;
  int? count;

  DetailedProgress({
    this.topicName, this.division, this.date, this.count
  });

  factory DetailedProgress.fromMap(Map<String, dynamic> json) => DetailedProgress(
    topicName: json["topicName"],
    division: json["division"],
    date: json["date"],
    count: json["count"],
  );
// Map<String, dynamic> toMap() {
//   throw UnimplementedError('toMap() must be implemented in a subclass');
// }
}