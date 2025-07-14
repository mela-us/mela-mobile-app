import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/entity/message_chat/conversation.dart';
import 'package:mela/domain/repository/chat/chat_repository.dart';
import 'package:mela/domain/usecase/user/logout_usecase.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

class GetConversationRequestParams {
  final String conversationId;
  final int limit;
  String? beforeMessageId;
  GetConversationRequestParams(
      {required this.conversationId,
      required this.limit,
      this.beforeMessageId});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["limit"] = limit;
    if (beforeMessageId != null) {
      map["before"] = beforeMessageId;
    }
    return map;
  }
}

class GetConversationUsecase
    extends UseCase<Conversation, GetConversationRequestParams> {
  final ChatRepository _chatRepository;
  final RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  final LogoutUseCase _logoutUseCase;
  GetConversationUsecase(this._chatRepository, this._refreshAccessTokenUsecase,
      this._logoutUseCase);

  @override
  Future<Conversation> call(
      {required GetConversationRequestParams params}) async {
    try {
      return await _chatRepository.getConversation(params);
    } catch (e) {
      if (e is DioException) {
        //eg accessToken is expired
        if (e.response?.statusCode == 401) {
          bool isRefreshTokenSuccess =
              await _refreshAccessTokenUsecase.call(params: null);
          if (isRefreshTokenSuccess) {
            print("----------->E1: $e");
            return await call(params: params);
          }
          //Call logout, logout will delete token in secure storage, shared preference.....
          await _logoutUseCase.call(params: null);
          rethrow;
          //.................
        }
        print("----------->E2: $e");
        rethrow;
      }
      print("----------->E3: $e");
      rethrow;
    }
  }
}
