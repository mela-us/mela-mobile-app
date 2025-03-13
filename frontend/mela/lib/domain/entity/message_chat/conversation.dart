import 'package:mela/domain/entity/message_chat/message_chat.dart';

class Conversation {
  String conversationId;
  String nameConversation;
  DateTime dateConversation;
  bool hasMore;
  List<MessageChat> messages;
  Conversation(
      {required this.conversationId,
      required this.messages,
      required this.hasMore,
      required this.dateConversation,
      required this.nameConversation});
  Conversation copyWith() {
    return Conversation(
      conversationId: this.conversationId,
      nameConversation: this.nameConversation,
      dateConversation: this.dateConversation,
      hasMore: this.hasMore,
      messages: List.from(this.messages),
    );
  }
}
