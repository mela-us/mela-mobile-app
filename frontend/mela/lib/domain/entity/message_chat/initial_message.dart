import 'package:mela/constants/enum.dart';
import 'package:mela/domain/entity/message_chat/message_chat.dart';

class StepGuilde {
  final String title;
  final String description;

  StepGuilde({required this.title, required this.description});

  factory StepGuilde.fromJson(Map<String, dynamic> json) {
    return StepGuilde(
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }
}

class InitialMessage extends MessageChat {
  final String solutionMethod;
  final String advice;
  final String analysis;
  final List<StepGuilde> steps;
  final List<String> relativeTerms;

  InitialMessage({
    required bool isAI,
    required this.solutionMethod,
    required this.advice,
    required this.analysis,
    required this.steps,
    required this.relativeTerms,
    DateTime? timestamp,
  }) : super(isAI: isAI, type: MessageType.initial, timestamp: timestamp);

  factory InitialMessage.fromJson(
      Map<String, dynamic> json, bool isAI, DateTime? timestamp) {
    final content = json['content'] as Map<String, dynamic>;
    final steps =
        (content['steps'] as List).map((step) => StepGuilde.fromJson(step)).toList();
    final relativeTerms = List<String>.from(content['relativeTerms']);
    return InitialMessage(
      isAI: isAI,
      solutionMethod: content['solutionMethod'] as String,
      advice: content['advice'] as String,
      analysis: content['analysis'] as String,
      steps: steps,
      relativeTerms: relativeTerms,
      timestamp: timestamp,
    );
  }
}
