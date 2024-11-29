class DividedLecture {
  final int ordinalNumber;
  final String dividedLectureName;
  final String lectureId;
  final String contentInDividedLecture; //if html
  final String urlContentInDividedLecture; //if pdf
  final String sectionType;

  DividedLecture({
    required this.ordinalNumber,
    required this.dividedLectureName,
    required this.lectureId,
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
      );
  Map<String, dynamic> toJson() => {
        "ordinalNumber": ordinalNumber,
        "name": dividedLectureName,
        "lectureId": lectureId,
        "content": contentInDividedLecture,
        "url": urlContentInDividedLecture,
        "sectionType": sectionType,
      };
  get pages => 10;
  get origin => "Mela";
}
