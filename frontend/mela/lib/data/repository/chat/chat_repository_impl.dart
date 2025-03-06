import 'package:mela/data/network/apis/chat/chat_api.dart';
import 'package:mela/domain/entity/message_chat/conversation.dart';
import 'package:mela/domain/entity/message_chat/message_chat.dart';
import 'package:mela/domain/repository/chat/chat_repository.dart';
import 'package:mela/domain/usecase/chat/send_message_chat_usecase.dart';

class ChatRepositoryImpl extends ChatRepository {
  ChatApi _chatApi;
  ChatRepositoryImpl(this._chatApi);
  @override
  Future<Conversation> getConversation(String conversationId) {
    return _chatApi.getConversation(conversationId);
  }

  @override
  Future<MessageChat> sendMessage(ChatRequestParams params) {
    return _chatApi.sendMessageChat(params);
  }
}
