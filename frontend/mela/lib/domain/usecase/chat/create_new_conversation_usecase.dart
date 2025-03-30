import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/entity/message_chat/conversation.dart';
import 'package:mela/domain/repository/chat/chat_repository.dart';
import 'package:mela/domain/usecase/presigned_image/get_presigned_image_usecase.dart';
import 'package:mela/domain/usecase/user/logout_usecase.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

class CreateNewConversationParams {
  final String? text;
  final File? imageFile;
  final String? imageUrl;

  CreateNewConversationParams({this.text, this.imageFile, this.imageUrl});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    if (text != null) {
      map["text"] = text;
    }
    if (imageUrl != null) {
      map["imageUrl"] = imageUrl;
    }
    return {
      "message": map,
    };
  }
}

class CreateNewConversationUsecase
    extends UseCase<Conversation, CreateNewConversationParams> {
  ChatRepository _chatRepository;
  RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  LogoutUseCase _logoutUseCase;
  GetPresignImageUsecase _getPresignImageUsecase;

  CreateNewConversationUsecase(
      this._chatRepository,
      this._refreshAccessTokenUsecase,
      this._logoutUseCase,
      this._getPresignImageUsecase);
  @override
  Future<Conversation> call(
      {required CreateNewConversationParams params}) async {
    try {
      String? imageUrl = null;
      if (params.imageFile != null) {
        imageUrl =
            await _getPresignImageUsecase.call(params: params.imageFile!);
      }

      return await _chatRepository
          .createNewConversation(CreateNewConversationParams(
        text: params.text,
        imageUrl: imageUrl,
      ));
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
