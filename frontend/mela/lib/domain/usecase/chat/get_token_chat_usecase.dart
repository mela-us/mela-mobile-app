import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/repository/chat/chat_repository.dart';
import 'package:mela/domain/usecase/user/logout_usecase.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

class GetTokenChatUsecase extends UseCase<int, void> {
  final ChatRepository _chatRepository;
  final RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  final LogoutUseCase _logoutUseCase;
  GetTokenChatUsecase(this._chatRepository, this._refreshAccessTokenUsecase,
      this._logoutUseCase);

  @override
  FutureOr<int> call({void params}) async {
    try {
      return _chatRepository.getTokenChat();
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          print("🔄 Attempting to refresh token...");
          bool isSuccess = await _refreshAccessTokenUsecase.call(params: null);
          if (isSuccess) {
            return await call(params: null);
          } else {
            await _logoutUseCase.call(params: null);
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
