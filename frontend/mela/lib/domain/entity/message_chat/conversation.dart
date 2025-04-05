import 'package:mela/constants/enum.dart';
import 'package:mela/domain/entity/message_chat/message_chat.dart';

class Conversation {
  String conversationId;
  String nameConversation;
  DateTime dateConversation;
  bool hasMore;
  LevelConversation levelConversation;
  List<MessageChat> messages;
  Conversation(
      {required this.conversationId,
      required this.messages,
      required this.hasMore,
      required this.dateConversation,
      required this.nameConversation,
      required this.levelConversation});
  Conversation copyWith() {
    return Conversation(
      conversationId: conversationId,
      nameConversation: nameConversation,
      dateConversation: dateConversation,
      hasMore: hasMore,
      messages: List.from(messages),
      levelConversation: levelConversation,
    );
  }

  factory Conversation.fromJson(Map<String, dynamic> json) {
    final messages = (json['message'] as List)
        .map((message) => MessageChat.fromJson(message))
        .toList();
    return Conversation(
      conversationId: json['conversationId'] as String,
      nameConversation: json['title'] as String,
      dateConversation:
          DateTime.tryParse(json['metadata']['createdAt']) ?? DateTime.now(),
      hasMore: false,
      messages: messages,
      levelConversation: LevelConversation.values
          .firstWhere((e) => e.name == json['metadata']['status'] as String),
    );
  }
}
