import 'package:mela/domain/entity/message_chat/message_chat.dart';

class Conversation {
  String conversationId;
  String nameConversation;
  List<MessageChat> messages;
  Conversation(
      {required this.conversationId,
      required this.messages,
      required this.nameConversation});
  Conversation copyWith({
    String? conversationId,
    String? nameConversation,
    List<MessageChat>? messages,
  }) {
    return Conversation(
      conversationId: conversationId ?? this.conversationId,
      nameConversation: nameConversation ?? this.nameConversation,
      messages: messages ??
          List.from(this
              .messages), // Tạo danh sách mới để tránh thay đổi danh sách gốc
    );
  }
}
