import 'package:mela/constants/enum.dart';
import 'package:mela/domain/entity/message_chat/message_chat.dart';

class ReviewMessage extends MessageChat {
  final String? explain;

  ReviewMessage({
    required bool isAI,
    required this.explain,
    DateTime? timestamp,
  }) : super(isAI: isAI, type: MessageType.review, timestamp: timestamp);

  factory ReviewMessage.fromJson(
      Map<String, dynamic> content, bool isAI, DateTime? timestamp) {
    return ReviewMessage(
      isAI: isAI,
      explain: content['explain'] as String?,
      timestamp: timestamp,
    );
  }
}
