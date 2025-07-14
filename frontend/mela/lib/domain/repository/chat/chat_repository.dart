import 'package:mela/domain/entity/chat/history_item.dart';
import 'package:mela/domain/entity/chat/history_response.dart';
import 'package:mela/domain/entity/message_chat/conversation.dart';
import 'package:mela/domain/usecase/chat/create_new_conversation_usecase.dart';
import 'package:mela/domain/usecase/chat/get_conversation_usecase.dart';
import 'package:mela/domain/usecase/chat/send_message_chat_usecase.dart';

abstract class ChatRepository {
  Future<Conversation> getConversation(GetConversationRequestParams params);
  Future<Conversation> sendMessage(
      ChatRequestParams
          params); //Response Conversation not MessageChat because title, status conversation will be updated
  Future<Conversation> createNewConversation(
      CreateNewConversationParams params);

  Future<Conversation> sendMessageReviewSubmission(ChatRequestParams params);
  Future<Conversation> sendMessageGetSolution(ChatRequestParams params);

  Future<HistoryResponse> getHistoryChat(DateTime? timestamp);
  Future<int> getTokenChat();
  Future<int> deleteConversationFromHistory(String conversationId);
}
