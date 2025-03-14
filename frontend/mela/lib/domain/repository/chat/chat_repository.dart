import 'package:mela/domain/entity/message_chat/conversation.dart';
import 'package:mela/domain/entity/message_chat/message_chat.dart';
import 'package:mela/domain/usecase/chat/get_conversation_usecase.dart';
import 'package:mela/domain/usecase/chat/send_message_chat_usecase.dart';

abstract class ChatRepository {
  Future<Conversation> getConversation(GetConversationRequestParams params);
  Future<MessageChat> sendMessage(ChatRequestParams params);
}
