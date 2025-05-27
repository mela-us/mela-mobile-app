import 'package:mela/constants/enum.dart';

class ReviseItem {
  String itemId;
  ReviewItemType type;
  String reviewId;
  int ordinalNumber;
  bool isDone;
  String lectureTitle;
  String topicTitle;
  String levelTitle;
  String? sectionUrl;

  ReviseItem({
    required this.itemId,
    required this.type,
    required this.reviewId,
    required this.ordinalNumber,
    required this.isDone,
    required this.lectureTitle,
    required this.topicTitle,
    required this.levelTitle,
    required this.sectionUrl,
  });
}
