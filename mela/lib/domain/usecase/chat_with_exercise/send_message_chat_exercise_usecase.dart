import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/entity/message_chat/conversation.dart';
import 'package:mela/domain/repository/chat_exercise/chat_exercise_repository.dart';
import 'package:mela/domain/usecase/presigned_image/get_presigned_image_usecase.dart';
import 'package:mela/domain/usecase/user/logout_usecase.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

class ChatExerciseRequestParams {
  final String questionId;
  final String? message;
  final List<File?>? images;
  final List<String>? imageUrlList;
  final String typeMessage;
  ChatExerciseRequestParams(
      {required this.questionId,
      required this.message,
      this.images,
      this.imageUrlList,
      this.typeMessage = "CUSTOM"});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    if (message != null &&
        message!.isNotEmpty &&
        typeMessage != "CLARIFY_QUESTION" &&
        typeMessage != "EXPLAIN_SOLUTION") {
      map["text"] = message;
    }
    // if (imageUrlList != null && imageUrlList!.isNotEmpty) {
    //   map["imageUrl"] =
    //       imageUrlList!.first; //Because currently, we only send one image
    // }
    map["type"] = typeMessage;

    return map;
  }
}

class SendMessageChatExerciseUsecase
    extends UseCase<Conversation, ChatExerciseRequestParams> {
  final ChatExerciseRepository _chatRepository;
  final RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  final LogoutUseCase _logoutUseCase;
  GetPresignImageUsecase _getPresignImageUsecase;
  SendMessageChatExerciseUsecase(
      this._chatRepository,
      this._refreshAccessTokenUsecase,
      this._logoutUseCase,
      this._getPresignImageUsecase);

  @override
  Future<Conversation> call({required ChatExerciseRequestParams params}) async {
    try {
      String? imageUrl = null;
      if (params.images != null && params.images!.isNotEmpty) {
        imageUrl =
            await _getPresignImageUsecase.call(params: params.images!.first!);
      }
      return await _chatRepository.sendMessageExercise(
          ChatExerciseRequestParams(
              questionId: params.questionId,
              message: params.message,
              typeMessage: params.typeMessage,
              imageUrlList: (imageUrl != null) ? [imageUrl] : []));
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
