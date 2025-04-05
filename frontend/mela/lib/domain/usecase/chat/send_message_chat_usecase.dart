import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/entity/message_chat/conversation.dart';
import 'package:mela/domain/entity/message_chat/message_chat.dart';
import 'package:mela/domain/repository/chat/chat_repository.dart';
import 'package:mela/domain/usecase/user/logout_usecase.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

class ChatRequestParams {
  final String? conversationId;
  final String? message;
  final List<File?>? images;
  final List<String>? imageUrlList;
  ChatRequestParams(
      {required this.conversationId,
      required this.message,
      this.images,
      this.imageUrlList});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    if (message != null && message!.isNotEmpty) {
      map["text"] = message;
    }
    if (imageUrlList != null) {
      map["imageUrl"] =
          imageUrlList!.first; //Because currently, we only send one image
    }
    return map;
  }
}

class SendMessageChatUsecase extends UseCase<Conversation, ChatRequestParams> {
  final ChatRepository _chatRepository;
  final RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  final LogoutUseCase _logoutUseCase;
  SendMessageChatUsecase(this._chatRepository, this._refreshAccessTokenUsecase,
      this._logoutUseCase);

  @override
  Future<Conversation> call({required ChatRequestParams params}) async {
    try {
      return await _chatRepository.sendMessage(params);
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
