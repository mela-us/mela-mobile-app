import 'package:mela/domain/entity/message_chat/explain_message.dart';
import 'package:mela/domain/entity/message_chat/initial_message.dart';
import 'package:mela/domain/entity/message_chat/review_message.dart';
import 'package:mela/domain/entity/message_chat/solution_message.dart';

import '../../../constants/enum.dart';
import 'normal_message.dart';

// class MessageChat {
//   final String? message;//Can null for display in UI
//   bool isAI;
//   List<ImageSource>? images;
//   MessageChat({this.message, required this.isAI, this.images});
// }

abstract class MessageChat {
  final bool isAI;
  final MessageType type;
  final DateTime? timestamp;
  final String? messageId;

  MessageChat({
    required this.isAI,
    required this.type,
    this.timestamp,
    this.messageId,
  });

  factory MessageChat.fromJson(Map<String, dynamic> json) {
    try {
      final content = json['content'] as Map<String, dynamic>;
      final messageId = json['messageId'] as String?;

      final messageType = determineMessageType(content);
      final isAI = json['role'] == 'assistant';
      final timestamp = json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : null;
      switch (messageType) {
        case MessageType.initial:
          return InitialMessage.fromJson(content, isAI, timestamp, messageId);
        case MessageType.normal:
          return NormalMessage.fromJson(content, isAI, timestamp, messageId);
        case MessageType.explain:
          return ExplainMessage.fromJson(content, isAI, timestamp, messageId);
        case MessageType.review:
          return ReviewMessage.fromJson(content, isAI, timestamp, messageId);
        case MessageType.solution:
          return SolutionMessage.fromJson(content, isAI, timestamp, messageId);
      }
    } catch (e) {
      print("Error in MessageChat.fromJson: $e");
      return NormalMessage.fromJson({}, false, null, null);
    }
  }

  static MessageType determineMessageType(Map<String, dynamic> response) {
    if (response.containsKey("text")) {
      return MessageType.normal;
    }

    if (response.containsKey("explain")) {
      return MessageType.explain;
    }

    if (response.containsKey("steps") &&
        response.containsKey("solutionMethod") &&
        response.containsKey("analysis") &&
        response.containsKey("advice") &&
        response.containsKey("relativeTerms")) {
      return MessageType.initial;
    }

    if (response.containsKey("submissionSummary") &&
        response.containsKey("status") &&
        response.containsKey("areasForImprovement") &&
        response.containsKey("guidance") &&
        response.containsKey("encouragement")) {
      return MessageType.review;
    }

    if (response.containsKey("problemSummary") &&
        response.containsKey("steps") &&
        response.containsKey("advice") &&
        response.containsKey("finalAnswer")) {
      return MessageType.solution;
    }

    return MessageType.normal;
  }
}
