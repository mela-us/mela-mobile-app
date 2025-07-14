import 'package:mela/constants/enum.dart';
import 'package:mela/domain/entity/message_chat/message_chat.dart';

class ExplainMessage extends MessageChat {
  final String? explain;

  ExplainMessage({
    required bool isAI,
    required this.explain,
    DateTime? timestamp,
    String? messageId,
  }) : super(
            isAI: isAI,
            type: MessageType.explain,
            timestamp: timestamp,
            messageId: messageId);

  factory ExplainMessage.fromJson(Map<String, dynamic> content, bool isAI,
      DateTime? timestamp, String? messageId) {
    return ExplainMessage(
      isAI: isAI,
      explain: content['explain'] as String?,
      timestamp: timestamp,
      messageId: messageId,
    );
  }
}
