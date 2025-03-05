import 'package:mela/domain/entity/message_chat/message_chat.dart';

class Conversation {
  String conversationId;
  String nameConversation;
  List<MessageChat> messages;
  Conversation(
      {required this.conversationId,
      required this.messages,
      required this.nameConversation});
}
