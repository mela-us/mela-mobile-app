import 'package:mela/domain/entity/revise/revise.dart';
import 'package:mela/domain/params/revise/update_review_param.dart';

abstract class ReviseRepository {
  Future<UserReviewsResponse> getRevise();
  Future<String> updateReview(UpdateReviewParam params);
}
