import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/params/revise/update_review_param.dart';
import 'package:mela/domain/repository/revise/revise_repository.dart';
import 'package:mela/domain/usecase/user/logout_usecase.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

class UpdateRevisionUsecase extends UseCase<String, UpdateReviewParam> {
  final ReviseRepository _reviseRepository;
  final RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  final LogoutUseCase _logoutUseCase;

  UpdateRevisionUsecase(this._reviseRepository, this._refreshAccessTokenUsecase,
      this._logoutUseCase);

  Future<String> call({required UpdateReviewParam params}) async {
    // Simulating a successful update operation
    try {
      return await _reviseRepository.updateReview(params);
    } catch (e) {
      if (e is DioException) {
        // Handle access token expiration
        if (e.response?.statusCode == 401) {
          bool isRefreshTokenSuccess =
              await _refreshAccessTokenUsecase.call(params: null);
          if (isRefreshTokenSuccess) {
            // Retry the update operation after refreshing the token
            return await call(params: params);
          }
          // Call logout, which will delete tokens from secure storage, shared preferences, etc.
          await _logoutUseCase.call(params: null);
          rethrow;
        }
        print("----------->E1: $e");
        rethrow;
      }
      print("----------->E2: $e");
      rethrow;
    }
  }
}
