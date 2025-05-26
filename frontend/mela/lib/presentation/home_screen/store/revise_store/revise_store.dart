import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/domain/entity/lecture/lecture.dart';
import 'package:mela/domain/entity/revise/revise.dart';
import 'package:mela/domain/entity/revise/revise_item.dart';
import 'package:mela/domain/params/revise/update_review_param.dart';
import 'package:mela/domain/usecase/revise/get_revision_usecase.dart';
import 'package:mela/domain/usecase/revise/update_revision_usecase.dart';
import 'package:mela/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

part 'revise_store.g.dart';

class ReviseStore = _ReviseStore with _$ReviseStore;

abstract class _ReviseStore with Store {
  // UseCase
  final GetRevisionUsecase _getRevisionUsecase;
  final UpdateRevisionUsecase _updateReviewUsecase;

  @observable
  UserReviewsResponse? userReviewsResponse;

  @observable
  ObservableList<ReviseItem> revisionItemList = ObservableList<ReviseItem>();

  @observable
  String errorString = ''; // for dioException

  @observable
  bool isUnAuthorized =
      false; // for call api failed with refresh token expired -> login again

  @computed
  bool get loading => fetchRevisionFuture.status == FutureStatus.pending;

  // Constructor
  _ReviseStore(this._getRevisionUsecase, this._updateReviewUsecase);

  @observable
  ObservableFuture<UserReviewsResponse?> fetchRevisionFuture =
      ObservableFuture<UserReviewsResponse?>(ObservableFuture.value(null));

  // Actions: -----------------------------------------------------------------------------------------------------------
  @action
  Future getRevision() async {
    final future = _getRevisionUsecase.call(params: null);
    fetchRevisionFuture = ObservableFuture(future);
    try {
      userReviewsResponse = await future;
      itemListParsing();
    } catch (e) {
      if (e is DioException) {
        errorString = DioExceptionUtil.handleError(e);
        if (e.response?.statusCode == 401) {
          isUnAuthorized = true;
        }
      } else {
        errorString = e.toString();
      }
    }
  }

  @action
  Future<String> updateReview(UpdateReviewParam params) async {
    try {
      return await _updateReviewUsecase.call(params: params);
    } catch (e) {
      if (e is DioException) {
        errorString = DioExceptionUtil.handleError(e);
        if (e.response?.statusCode == 401) {
          isUnAuthorized = true;
        }
      } else {
        errorString = e.toString();
      }
      rethrow;
    }
  }

  void itemListParsing() {
    if (userReviewsResponse != null) {
      revisionItemList.clear();
      for (var item in userReviewsResponse!.reviews) {
        List<Exercise> exercises = item.exerciseList ?? [];
        List<Section> sections = item.sectionList ?? [];

        for (var ex in exercises) {
          revisionItemList.add(
            ReviseItem(
              reviewId: item.reviewId,
              itemId: ex.exerciseId,
              type: ReviewItemType.EXERCISE,
              ordinalNumber: ex.ordinalNumber,
              isDone: ex.isDone,
              lectureTitle: ex.lectureTitle,
              topicTitle: ex.topicTitle,
              levelTitle: ex.levelTitle,
            ),
          );
        }

        for (var sec in sections) {
          revisionItemList.add(
            ReviseItem(
              reviewId: item.reviewId,
              itemId: sec.lectureId,
              type: ReviewItemType.SECTION,
              ordinalNumber: sec.ordinalNumber,
              isDone: sec.isDone,
              lectureTitle: sec.lectureTitle,
              topicTitle: sec.topicTitle,
              levelTitle: sec.levelTitle,
            ),
          );
        }
      }
    } else {
      revisionItemList.clear();
    }
  }
}
