import 'package:mela/constants/enum.dart';
import 'package:mela/domain/entity/message_chat/message_chat.dart';

class SolutionStep {
  final String title;
  final String explanation;
  final String calculation;

  SolutionStep({
    required this.title,
    required this.explanation,
    required this.calculation,
  });

  factory SolutionStep.fromJson(Map<String, dynamic> json) {
    return SolutionStep(
      title: json['title'] as String,
      explanation: json['explanation'] as String,
      calculation: json['calculation'] as String,
    );
  }
}

class SolutionMessage extends MessageChat {
  final String? advice;
  final String? problemSummary;
  final String? finalAnswer;
  final List<SolutionStep> steps;

  SolutionMessage({
    required bool isAI,
    this.advice,
    this.problemSummary,
    this.finalAnswer,
    required this.steps,
    DateTime? timestamp,
    String? messageId,
  }) : super(isAI: isAI, type: MessageType.solution, timestamp: timestamp, messageId: messageId);

  factory SolutionMessage.fromJson(
      Map<String, dynamic> content, bool isAI, DateTime? timestamp, String? messageId) {
    final stepsJson = content['steps'] as List<dynamic>? ?? [];
    final steps = stepsJson
        .map((step) => SolutionStep.fromJson(step as Map<String, dynamic>))
        .toList();

    return SolutionMessage(
      isAI: isAI,
      advice: content['advice'] as String?,
      problemSummary: content['problemSummary'] as String?,
      finalAnswer: content['finalAnswer'] as String?,
      steps: steps,
      timestamp: timestamp,
      messageId: messageId,
    );
  }
}
