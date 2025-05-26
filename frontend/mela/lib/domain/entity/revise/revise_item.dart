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

  ReviseItem({
    required this.itemId,
    required this.type,
    required this.reviewId,
    required this.ordinalNumber,
    required this.isDone,
    required this.lectureTitle,
    required this.topicTitle,
    required this.levelTitle,
  });
}
