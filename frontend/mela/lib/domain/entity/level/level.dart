class Level {
  String levelId;
  String levelName;
  String levelImagePath;
  Level(
      {required this.levelId,
      required this.levelName,
      required this.levelImagePath});
  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      levelId: json['levelId'],
      levelName: json['name'],
      levelImagePath: json['imageUrl'] ?? "",
    );
  }
}
