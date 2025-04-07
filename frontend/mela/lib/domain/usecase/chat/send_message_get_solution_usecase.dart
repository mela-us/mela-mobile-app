import 'package:dio/dio.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/entity/message_chat/conversation.dart';
import 'package:mela/domain/repository/chat/chat_repository.dart';
import 'package:mela/domain/usecase/chat/send_message_chat_usecase.dart';
import 'package:mela/domain/usecase/user/logout_usecase.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

class SendMessageGetSolutionUsecase
    extends UseCase<Conversation, ChatRequestParams> {
  ChatRepository _chatRepository;
  RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  LogoutUseCase _logoutUseCase;

  SendMessageGetSolutionUsecase(
    this._chatRepository,
    this._refreshAccessTokenUsecase,
    this._logoutUseCase,
  );
  @override
  Future<Conversation> call({required ChatRequestParams params}) async {
    try {
      final result =
          await _chatRepository.sendMessageGetSolution(ChatRequestParams(
        conversationId: params.conversationId,
        message: params.message,
      ));
      print("----------->result send message with getSolution: $result");
      return result;
    } catch (e) {
      if (e is DioException) {
        //eg accessToken is expired
        if (e.response?.statusCode == 401) {
          bool isRefreshTokenSuccess =
              await _refreshAccessTokenUsecase.call(params: null);
          if (isRefreshTokenSuccess) {
            print("----------->E1 error is refresh token in get solution: $e");
            return await call(params: params);
          }
          //Call logout, logout will delete token in secure storage, shared preference.....
          await _logoutUseCase.call(params: null);
          rethrow;
          //.................
        }
        print("----------->E2 in get solution: $e");
        rethrow;
      }
      print("----------->E3  in get solution: $e");
      rethrow;
    }
  }
}
