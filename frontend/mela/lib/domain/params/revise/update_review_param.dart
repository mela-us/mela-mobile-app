import 'package:mela/constants/enum.dart';

class UpdateReviewParam {
  final String reviewId;
  final String itemId;
  final int ordinalNumber;
  final ReviewItemType itemType;
  final bool isDone;

  UpdateReviewParam(
      {required this.reviewId,
      required this.itemId,
      required this.ordinalNumber,
      required this.itemType,
      required this.isDone});
}
