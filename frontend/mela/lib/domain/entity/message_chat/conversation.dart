import 'package:mela/domain/entity/message_chat/initial_message.dart';
import 'package:mela/domain/entity/message_chat/message_chat.dart';
import 'package:mela/domain/entity/message_chat/normal_message.dart';

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

  factory Conversation.fromJson(Map<String, dynamic> json) {
    final messages = (json['message'] as List)
        .map((message) => MessageChat.fromJson(message))
        .toList();
    final a = Conversation(
      conversationId: json['conversationId'] as String,
      nameConversation: json['title'] as String,
      dateConversation: DateTime.now(),
      hasMore: false,
      messages: messages,
    );
    for (var message in messages) {
      if (message is NormalMessage) {
        print("------------>messageNormal: ${message.text}");
      }
      if (message is InitialMessage) {
        print("------------>messageInitial: advice ${message.advice}");
      }
    }
    return a;
  }
}
