import 'dart:async';

import 'package:mela/data/network/constants/endpoints_const.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/domain/entity/revise/revise.dart';
import 'package:mela/domain/params/revise/update_review_param.dart';

class ReviseApi {
  final DioClient _dioClient;
  ReviseApi(this._dioClient);

  Future<UserReviewsResponse> getRevise() async {
    final res = await _dioClient.dio.get(
      EndpointsConst.getRevise,
    );
    if (res.statusCode == 200) {
      UserReviewsResponse userReviewsResponse =
          UserReviewsResponse.fromJson(res.data);
      return userReviewsResponse;
    } else if (res.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception("Unknown error");
    }
  }

  Future<String> updateReview(UpdateReviewParam params) async {
    var body = {
      "type": params.itemType.name,
      "itemId": params.itemId,
      "ordinalNumber": params.ordinalNumber,
      "isDone": params.isDone,
    };

    final res = await _dioClient.dio.post(
      EndpointsConst.updateReview(params.reviewId),
      data: body,
    );
    if (res.statusCode == 200) {
      return res.data['message'];
    } else if (res.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      throw Exception("Unknown error");
    }
  }
}
