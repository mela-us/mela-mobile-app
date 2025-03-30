import 'dart:io';

import 'package:mela/domain/entity/image_source/image_source.dart';
import 'package:mela/domain/entity/message_chat/initial_message.dart';

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

  MessageChat({
    required this.isAI,
    required this.type,
    this.timestamp,
  });

  factory MessageChat.fromJson(Map<String, dynamic> json) {
    final typeStr = json['type'] as String? ??
        (json['content'] != null && json['content']['solutionMethod'] != null
            ? 'initial'
            : 'normal');
    final isAI = json['role'] == 'assistant';
    final timestamp = json['timestamp'] != null
        ? DateTime.parse(json['timestamp'] as String)
        : null;
  print("------------>typeStr: $typeStr");

    switch (typeStr) {
      case 'initial':
        return InitialMessage.fromJson(json, isAI, timestamp);
      case 'normal':
        return NormalMessage.fromJson(json, isAI, timestamp);
      default:
        return InitialMessage.fromJson(json, isAI, timestamp);
    }
  }
}
