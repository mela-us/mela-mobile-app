import 'package:mela/constants/enum.dart';
import 'package:mela/domain/entity/message_chat/message_chat.dart';

class ExplainMessage extends MessageChat {
  final String? explain;

  ExplainMessage({
    required bool isAI,
    required this.explain,
    DateTime? timestamp,
  }) : super(isAI: isAI, type: MessageType.explain, timestamp: timestamp);

  factory ExplainMessage.fromJson(
      Map<String, dynamic> content, bool isAI, DateTime? timestamp) {
    return ExplainMessage(
      isAI: isAI,
      explain: content['explain'] as String?,
      timestamp: timestamp,
    );
  }
}
