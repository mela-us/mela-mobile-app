import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/entity/chat/history_item.dart';
import 'package:mela/domain/repository/chat/chat_repository.dart';
import 'package:mela/domain/usecase/user/logout_usecase.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

class GetHistoryChatUsecase extends UseCase<List<HistoryItem>, void> {
  final ChatRepository _chatRepository;
  final RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  final LogoutUseCase _logoutUseCase;

  GetHistoryChatUsecase(this._chatRepository, this._refreshAccessTokenUsecase,
      this._logoutUseCase);

  @override
  Future<List<HistoryItem>> call({required void params}) async {
    try {
      return _chatRepository.getHistoryChat();
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          print("🔄 Attempting to refresh token...");
          bool isSuccess = await _refreshAccessTokenUsecase.call(params: null);
          if (isSuccess) {
            return await call(params: null);
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
