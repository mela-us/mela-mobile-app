import 'package:flutter/material.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/domain/entity/message_chat/explain_message.dart';
import 'package:mela/domain/entity/message_chat/initial_message.dart';
import 'package:mela/domain/entity/message_chat/message_chat.dart';
import 'package:mela/domain/entity/message_chat/normal_message.dart';
import 'package:mela/presentation/thread_chat/widgets/message_type_tile/explain_message_title.dart';
import 'package:mela/presentation/thread_chat/widgets/message_type_tile/initial_message_title.dart';
import 'package:mela/presentation/thread_chat/widgets/message_type_tile/normal_message_title.dart';

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
        return NormalMessageTitle(
            currentMessage: currentMessage as NormalMessage);
      case MessageType.initial:
        return InitialMessageTitle(
            currentMessage: currentMessage as InitialMessage);
      case MessageType.explain:
        return ExplainMessageTile(
            currentMessage: currentMessage as ExplainMessage);
      case MessageType.solution:
      case MessageType.review:
        return const SizedBox();
    }
  }
}
