class Progress{
  String? id;
  String? topicName;
  String? division;
  int? current;
  int? total;


  Progress({
    this.id, this.topicName, this.division, this.current, this.total
  });

  factory Progress.fromMap(Map<String, dynamic> json) => Progress(
    id: json["id"],
    topicName: json["topicName"],
    division: json["division"],
    current: json["current"],
    total: json["total"],
  );
  // Map<String, dynamic> toMap() {
  //   throw UnimplementedError('toMap() must be implemented in a subclass');
  // }
}