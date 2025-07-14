import 'package:mela/data/network/apis/revise/revise_api.dart';
import 'package:mela/domain/entity/revise/revise.dart';
import 'package:mela/domain/params/revise/update_review_param.dart';
import 'package:mela/domain/repository/revise/revise_repository.dart';

class ReviseRepositoryImpl extends ReviseRepository {
  final ReviseApi _reviseApi;
  ReviseRepositoryImpl(this._reviseApi);

  @override
  Future<UserReviewsResponse> getRevise() async {
    return _reviseApi.getRevise();
  }

  @override
  Future<String> updateReview(UpdateReviewParam params) async {
    return _reviseApi.updateReview(params);
  }
}
