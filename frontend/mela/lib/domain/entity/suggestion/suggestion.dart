import 'package:mela/domain/entity/divided_lecture/divided_lecture.dart';

class ListSuggestion {
  final List<Suggestion> suggestions;

  ListSuggestion({
    required this.suggestions,
  });

  factory ListSuggestion.fromJson(Map<String, dynamic> json) => ListSuggestion(
        suggestions: List<Suggestion>.from(
            json["suggestions"].map((e) => Suggestion.fromJson(e))),
      );
}

class Suggestion {
  final String suggestionId;
  final List<Section> sectionList;

  Suggestion({
    required this.suggestionId,
    required this.sectionList,
  });

  factory Suggestion.fromJson(Map<String, dynamic> json) => Suggestion(
        suggestionId: json["suggestionId"],
        sectionList: List<Section>.from(
            json["sectionList"].map((e) => Section.fromJson(e))),
      );
}

class Section {
  String lectureId;
  int ordinalNumber;
  bool isDone;
  String lectureTitle;
  String topicTitle;
  String levelTitle;
  String sectionUrl;

  Section({
    required this.lectureId,
    required this.ordinalNumber,
    required this.isDone,
    required this.lectureTitle,
    required this.topicTitle,
    required this.levelTitle,
    required this.sectionUrl,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        lectureId: json["lectureId"],
        ordinalNumber: json["ordinalNumber"],
        isDone: json["isDone"],
        lectureTitle: json["lectureTitle"],
        topicTitle: json["topicTitle"],
        levelTitle: json["levelTitle"],
        sectionUrl: json["sectionUrl"],
      );

  DividedLecture get toDividedLectureFromSection => DividedLecture(
        ordinalNumber: ordinalNumber,
        dividedLectureName: lectureTitle,
        lectureId: lectureId,
        topicId: "", //not important in this case
        levelId: "", //not important in this case
        contentInDividedLecture: "", //not important in this case
        urlContentInDividedLecture: sectionUrl, //url of pdf
        sectionType: "PDF",
      );
}
