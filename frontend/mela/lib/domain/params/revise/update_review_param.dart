import 'package:mela/constants/enum.dart';
import 'package:mela/domain/entity/revise/revise.dart';

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
