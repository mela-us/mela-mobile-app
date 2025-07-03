import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/entity/chat/history_item.dart';
import 'package:mela/domain/repository/chat/chat_repository.dart';
import 'package:mela/domain/usecase/user/logout_usecase.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

class DeleteConversationUsecase extends UseCase<int, String> {
  final ChatRepository _chatRepository;
  final RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  final LogoutUseCase _logoutUseCase;

  DeleteConversationUsecase(this._chatRepository,
      this._refreshAccessTokenUsecase, this._logoutUseCase);

  @override
  FutureOr<int> call({required String params}) async {
    // TODO: implement call
    try {
      return _chatRepository.deleteConversationFromHistory(params);
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          print("🔄 Attempting to refresh token...");
          bool isSuccess = await _refreshAccessTokenUsecase.call(params: null);
          if (isSuccess) {
            return await call(params: params);
          } else {
            await _logoutUseCase.call(params: null);
            //temporary
            rethrow;
          }
        } else {
          rethrow;
        }
      }
      rethrow;
    }
  }
}
