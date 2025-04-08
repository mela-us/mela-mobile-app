import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/domain/entity/message_chat/initial_message.dart';
import 'package:mela/presentation/thread_chat/store/chat_box_store/chat_box_store.dart';
import 'package:mela/presentation/thread_chat/store/thread_chat_store/thread_chat_store.dart';
import 'package:mela/presentation/thread_chat/widgets/convert_string_to_latex.dart';
import 'package:mela/presentation/thread_chat/widgets/message_type_tile/button_submission_review.dart';
import 'package:mela/presentation/thread_chat/widgets/message_type_tile/support_icon_in_message.dart';

class InitialMessageTile extends StatelessWidget {
  final ThreadChatStore _threadChatStore = getIt.get<ThreadChatStore>();
  final ChatBoxStore _chatBoxStore = getIt.get<ChatBoxStore>();
  final InitialMessage currentMessage;

  InitialMessageTile({super.key, required this.currentMessage});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      bool isEnabledSubmission =
          _threadChatStore.currentConversation.levelConversation ==
                  LevelConversation.PROBLEM_IDENTIFIED ||
              _threadChatStore.currentConversation.levelConversation ==
                  LevelConversation.SUBMISSION_REVIEWED;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Solution Method
                _buildSolutionMethod(context),
                const SizedBox(height: 10),

                // Analysis
                _buildAnalysis(context),
                const SizedBox(height: 10),

                // Steps
                _buildSteps(context),
                const SizedBox(height: 10),

                // Advice
                _buildAdvice(context),
                const SizedBox(height: 10),

                // Relative Terms
                _buildRelativeTerms(context),
                const SizedBox(height: 8),

                // Support Icons: Like, unlike, copy
                 SupportIconInMessage(),

                const SizedBox(height: 8),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.85,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonSubmissionReview(
                        isEnabled: isEnabledSubmission,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ],
        ),
      );
    });
  }

  // Solution Method Container
  Widget _buildSolutionMethod(BuildContext context) {
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
            "Phương pháp giải:",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.65,
                  color: Colors.blue[700], // Màu xanh đậm cho tiêu đề
                ),
          ),
          const SizedBox(height: 5),
          ConvertStringToLatex(rawText: currentMessage.solutionMethod),

          // Text(
          //   currentMessage.solutionMethod,
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

  // Analysis Container
  Widget _buildAnalysis(BuildContext context) {
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
            "Phân tích:",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.65,
                  color: Colors.green[700], // Màu xanh lá đậm cho tiêu đề
                ),
          ),
          const SizedBox(height: 5),
          ConvertStringToLatex(rawText: currentMessage.analysis),
          // Text(
          //   currentMessage.analysis,
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
            "Các bước thực hiện:",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.65,
                  color: Colors.yellow[800], // Màu vàng đậm cho tiêu đề
                ),
          ),
          const SizedBox(height: 5),
          ...currentMessage.steps.asMap().entries.map((entry) {
            int index = entry.key;
            StepGuilde step = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConvertStringToLatex(
                    rawText: step.title,
                    isStep: true,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  ConvertStringToLatex(rawText: step.description),
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
          ConvertStringToLatex(rawText: currentMessage.advice),
          // Text(
          //   currentMessage.advice,
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

  // Relative Terms Container
  Widget _buildRelativeTerms(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.85,
      ),
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Từ khóa liên quan:",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.65,
                  color: Colors.orange[700], // Màu cam đậm cho tiêu đề
                ),
          ),
          const SizedBox(height: 5),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: currentMessage.relativeTerms
                .map((term) => ElevatedButton(
                      onPressed: () async {
                        if (_threadChatStore.isLoading) {
                          return;
                        }
                        await _threadChatStore.sendChatMessage(term, []);
                        //Using for while loading response user enter new message availale
                        if (_chatBoxStore.contentMessage.isNotEmpty ||
                            _chatBoxStore.images.isNotEmpty) {
                          _chatBoxStore.setShowSendIcon(true);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .secondaryContainer, // Màu nền khác với background
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: ConvertStringToLatex(rawText: term),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
