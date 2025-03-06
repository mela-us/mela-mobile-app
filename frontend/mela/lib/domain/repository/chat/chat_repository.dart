import 'package:mela/domain/entity/message_chat/conversation.dart';
import 'package:mela/domain/entity/message_chat/message_chat.dart';
import 'package:mela/domain/usecase/chat/send_message_chat_usecase.dart';

abstract class ChatRepository {
  Future<Conversation> getConversation(String conversationId);
  Future<MessageChat> sendMessage(ChatRequestParams params);
}
