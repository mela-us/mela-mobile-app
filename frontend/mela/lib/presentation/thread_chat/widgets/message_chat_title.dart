import 'package:flutter/material.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/domain/entity/message_chat/explain_message.dart';
import 'package:mela/domain/entity/message_chat/initial_message.dart';
import 'package:mela/domain/entity/message_chat/message_chat.dart';
import 'package:mela/domain/entity/message_chat/normal_message.dart';
import 'package:mela/domain/entity/message_chat/review_message.dart';
import 'package:mela/domain/entity/message_chat/solution_message.dart';
import 'package:mela/presentation/thread_chat/widgets/message_type_tile/explain_message_tile.dart';
import 'package:mela/presentation/thread_chat/widgets/message_type_tile/initial_message_tile.dart';
import 'package:mela/presentation/thread_chat/widgets/message_type_tile/normal_message_tile.dart';
import 'package:mela/presentation/thread_chat/widgets/message_type_tile/review_message_tile.dart';
import 'package:mela/presentation/thread_chat/widgets/message_type_tile/solution_message_tile.dart';

class MessageChatTitle extends StatelessWidget {
  final MessageChat currentMessage;

  const MessageChatTitle({
    super.key,
    required this.currentMessage,
  });

  @override
  Widget build(BuildContext context) {
    switch (currentMessage.type) {
      case MessageType.normal:
        return NormalMessageTile(
            currentMessage: currentMessage as NormalMessage);
      case MessageType.initial:
        return InitialMessageTile(
            currentMessage: currentMessage as InitialMessage);
      case MessageType.explain:
        return ExplainMessageTile(
            currentMessage: currentMessage as ExplainMessage);
      case MessageType.review:
        return ReviewMessageTile(
            currentMessage: currentMessage as ReviewMessage);
      case MessageType.solution:
        return SolutionMessageTile(
            currentMessage: currentMessage as SolutionMessage);
    }
  }
}
