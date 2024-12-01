class Level {
  String levelId;
  String levelName;
  Level({required this.levelId, required this.levelName});
  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      levelId: json['levelId'],
      levelName: json['name'],
    );
  }
}