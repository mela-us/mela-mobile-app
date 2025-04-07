import 'package:mela/constants/enum.dart';
import 'package:mela/domain/entity/message_chat/message_chat.dart';

enum ReviewStatus {
  correct,
  incorrect,
}

class ReviewMessage extends MessageChat {
  final String? submissionSummary;
  final String? guidance;
  final String? encouragement;
  final String? areasForImprovement;
  final ReviewStatus status;

  ReviewMessage({
    required bool isAI,
    this.submissionSummary,
    this.guidance,
    this.encouragement,
    this.areasForImprovement,
    required this.status,
    DateTime? timestamp,
  }) : super(isAI: isAI, type: MessageType.review, timestamp: timestamp);

  factory ReviewMessage.fromJson(
      Map<String, dynamic> content, bool isAI, DateTime? timestamp) {
    return ReviewMessage(
      isAI: isAI,
      submissionSummary: content['submissionSummary'] as String?,
      guidance: content['guidance'] as String?,
      encouragement: content['encouragement'] as String?,
      areasForImprovement: content['areasForImprovement'] as String?,
      status: _parseStatus(content['status'] as String?),
      timestamp: timestamp,
    );
  }

  static ReviewStatus _parseStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'correct':
        return ReviewStatus.correct;
      case 'incorrect':
        return ReviewStatus.incorrect;
      default:
        return ReviewStatus.incorrect;
    }
  }
}
