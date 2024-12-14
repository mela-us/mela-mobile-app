class DividedLecture {
  final int ordinalNumber;
  final String dividedLectureName;
  final String lectureId;
  final String topicId;
  final String levelId;
  final String contentInDividedLecture; //if html
  final String urlContentInDividedLecture; //if pdf
  final String sectionType;

  DividedLecture({
    required this.ordinalNumber,
    required this.dividedLectureName,
    required this.lectureId,
    required this.topicId,
    required this.levelId,
    required this.contentInDividedLecture,
    required this.urlContentInDividedLecture,
    required this.sectionType,
  });
  factory DividedLecture.fromJson(Map<String, dynamic> json) => DividedLecture(
        ordinalNumber: json["ordinalNumber"],
        dividedLectureName: json["name"],
        lectureId: json["lectureId"],
        contentInDividedLecture: json["content"],
        urlContentInDividedLecture: json["url"],
        sectionType: json["sectionType"],
        topicId: json["topicId"],
        levelId: json["levelId"],
      );
  Map<String, dynamic> toJson() => {
        "ordinalNumber": ordinalNumber,
        "name": dividedLectureName,
        "lectureId": lectureId,
        "content": contentInDividedLecture,
        "url": urlContentInDividedLecture,
        "sectionType": sectionType,
        "topicId": topicId,
        "levelId": levelId,
      };
  get pages => 10;
  get origin => "Mela";
}
