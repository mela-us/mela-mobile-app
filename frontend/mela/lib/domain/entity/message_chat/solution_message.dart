import 'package:mela/constants/enum.dart';
import 'package:mela/domain/entity/message_chat/message_chat.dart';

class SolutionMessage extends MessageChat {
  final String? explain;

  SolutionMessage({
    required bool isAI,
    required this.explain,
    DateTime? timestamp,
  }) : super(isAI: isAI, type: MessageType.solution, timestamp: timestamp);

  factory SolutionMessage.fromJson(
      Map<String, dynamic> content, bool isAI, DateTime? timestamp) {
    return SolutionMessage(
      isAI: isAI,
      explain: content['explain'] as String?,
      timestamp: timestamp,
    );
  }
}
