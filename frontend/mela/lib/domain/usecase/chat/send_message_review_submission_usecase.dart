import 'package:dio/dio.dart';
import 'package:mela/core/domain/usecase/use_case.dart';
import 'package:mela/domain/entity/message_chat/conversation.dart';
import 'package:mela/domain/repository/chat/chat_repository.dart';
import 'package:mela/domain/usecase/chat/send_message_chat_usecase.dart';
import 'package:mela/domain/usecase/presigned_image/get_presigned_image_usecase.dart';
import 'package:mela/domain/usecase/user/logout_usecase.dart';
import 'package:mela/domain/usecase/user_login/refresh_access_token_usecase.dart';

class SendMessageReviewSubmissionUsecase
    extends UseCase<Conversation, ChatRequestParams> {
  ChatRepository _chatRepository;
  RefreshAccessTokenUsecase _refreshAccessTokenUsecase;
  LogoutUseCase _logoutUseCase;
  GetPresignImageUsecase _getPresignImageUsecase;

  SendMessageReviewSubmissionUsecase(
      this._chatRepository,
      this._refreshAccessTokenUsecase,
      this._logoutUseCase,
      this._getPresignImageUsecase);
  @override
  Future<Conversation> call({required ChatRequestParams params}) async {
    try {
      String? imageUrl = null;
      if (params.images != null && params.images!.isNotEmpty) {
        imageUrl =
            await _getPresignImageUsecase.call(params: params.images!.first!);
      }

      final result = await _chatRepository.sendMessageReviewSubmission(
          ChatRequestParams(
              conversationId: params.conversationId,
              message: params.message,
              imageUrlList: (imageUrl != null) ? [imageUrl] : []));
      print("----------->result send message with review submission: $result");
      return result;
    } catch (e) {
      if (e is DioException) {
        //eg accessToken is expired
        if (e.response?.statusCode == 401) {
          bool isRefreshTokenSuccess =
              await _refreshAccessTokenUsecase.call(params: null);
          if (isRefreshTokenSuccess) {
            print(
                "----------->E1 error is refresh token in review submission: $e");
            return await call(params: params);
          }
          //Call logout, logout will delete token in secure storage, shared preference.....
          await _logoutUseCase.call(params: null);
          rethrow;
          //.................
        }
        print("----------->E2 in  in review submission: $e");
        rethrow;
      }
      print("----------->E3 in  in review submissionn: $e");
      rethrow;
    }
  }
}
