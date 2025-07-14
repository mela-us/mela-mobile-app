import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/domain/entity/message_chat/solution_message.dart';
import 'package:mela/presentation/thread_chat/widgets/convert_string_to_latex.dart';
import 'package:mela/presentation/thread_chat/widgets/message_type_tile/support_icon_in_message.dart';

class SolutionMessageTile extends StatelessWidget {
  final SolutionMessage currentMessage;

  const SolutionMessageTile({super.key, required this.currentMessage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Problem Summary
              if (currentMessage.problemSummary != null)
                _buildProblemSummary(context),
              if (currentMessage.problemSummary != null)
                const SizedBox(height: 10),

              // Steps
              _buildSteps(context),
              const SizedBox(height: 10),

              // Final Answer
              if (currentMessage.finalAnswer != null)
                _buildFinalAnswer(context),
              if (currentMessage.finalAnswer != null)
                const SizedBox(height: 10),

              // Advice
              if (currentMessage.advice != null) _buildAdvice(context),
              if (currentMessage.advice != null) const SizedBox(height: 10),

              // Support Icons: Like, unlike, copy
              SupportIconInMessage(
                textCopy: _buildFullMessageText(),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ],
      ),
    );
  }

  // Problem Summary Container
  Widget _buildProblemSummary(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.85,
      ),
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border:
            Border.all(color: Theme.of(context).colorScheme.buttonYesBgOrText),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Đề bài:",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.65,
                  color: Colors.blue[700], // Màu xanh đậm cho tiêu đề
                ),
          ),
          const SizedBox(height: 5),
          ConvertStringToLatex(text: currentMessage.problemSummary!),
          // Text(
          //   currentMessage.problemSummary!,
          //   style: Theme.of(context).textTheme.content.copyWith(
          //         color: Colors.black,
          //         fontSize: 17,
          //         letterSpacing: 0.65,
          //         height: 1.65,
          //       ),
          // ),
        ],
      ),
    );
  }

  // Steps Container
  Widget _buildSteps(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.85,
      ),
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border:
            Border.all(color: Theme.of(context).colorScheme.buttonYesBgOrText),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Các bước giải:",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.65,
                  color: Colors.green[700],
                ),
          ),
          const SizedBox(height: 5),
          ...currentMessage.steps.asMap().entries.map((entry) {
            int index = entry.key;
            SolutionStep step = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ConvertStringToLatex(text: step.title, isStep: true),
                  ConvertStringToLatex(text: step.title),
                  const SizedBox(height: 3),
                  ConvertStringToLatex(text: step.explanation),
                  const SizedBox(height: 3),
                  ConvertStringToLatex(text: step.calculation),
                  if (index != currentMessage.steps.length - 1)
                    const Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                      height: 20,
                    ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  // Final Answer Container
  Widget _buildFinalAnswer(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.85,
      ),
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border:
            Border.all(color: Theme.of(context).colorScheme.buttonYesBgOrText),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Đáp án cuối cùng:",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.65,
                  color: Colors.orange[700], // Màu cam đậm cho tiêu đề
                ),
          ),
          const SizedBox(height: 5),
          ConvertStringToLatex(text: currentMessage.finalAnswer!),
          // Text(
          //   currentMessage.finalAnswer!,
          //   style: Theme.of(context).textTheme.content.copyWith(
          //         color: Colors.black,
          //         fontSize: 17,
          //         letterSpacing: 0.65,
          //         height: 1.65,
          //       ),
          // ),
        ],
      ),
    );
  }

  // Advice Container
  Widget _buildAdvice(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.85,
      ),
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border:
            Border.all(color: Theme.of(context).colorScheme.buttonYesBgOrText),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Lời khuyên:",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.65,
                  color: Colors.purple[700], // Màu tím đậm cho tiêu đề
                ),
          ),
          const SizedBox(height: 5),
          ConvertStringToLatex(text: currentMessage.advice!),
          // Text(
          //   currentMessage.advice!,
          //   style: Theme.of(context).textTheme.content.copyWith(
          //         color: Colors.black,
          //         fontSize: 17,
          //         letterSpacing: 0.65,
          //         height: 1.65,
          //       ),
          // ),
        ],
      ),
    );
  }

  String _buildFullMessageText() {
    StringBuffer fullText = StringBuffer();

    // Problem Summary
    if (currentMessage.problemSummary != null) {
      fullText.writeln("Đề bài:");
      fullText.writeln(currentMessage.problemSummary);
      fullText.writeln();
    }

    // Steps
    fullText.writeln("Các bước giải:");
    for (int i = 0; i < currentMessage.steps.length; i++) {
      fullText.writeln("${currentMessage.steps[i].title}");
      fullText.writeln("${currentMessage.steps[i].explanation}");
      fullText.writeln("${currentMessage.steps[i].calculation}");
      if (i < currentMessage.steps.length - 1) {
        fullText.writeln("---");
      }
    }
    fullText.writeln();

    // Final Answer
    if (currentMessage.finalAnswer != null) {
      fullText.writeln("Đáp án cuối cùng:");
      fullText.writeln(currentMessage.finalAnswer);
      fullText.writeln();
    }

    // Advice
    if (currentMessage.advice != null) {
      fullText.writeln("Lời khuyên:");
      fullText.writeln(currentMessage.advice);
    }

    return fullText.toString();
  }
}
