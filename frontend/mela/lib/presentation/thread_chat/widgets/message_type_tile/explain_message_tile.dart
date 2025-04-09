import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/domain/entity/message_chat/explain_message.dart';
import 'package:mela/presentation/thread_chat/store/thread_chat_store/thread_chat_store.dart';
import 'package:mela/presentation/thread_chat/widgets/convert_string_to_latex.dart';
import 'package:mela/presentation/thread_chat/widgets/message_type_tile/button_submission_review.dart';
import 'package:mela/presentation/thread_chat/widgets/message_type_tile/message_loading_response.dart';
import 'package:mela/presentation/thread_chat/widgets/message_type_tile/support_icon_in_message.dart';

class ExplainMessageTile extends StatelessWidget {
  final ThreadChatStore _threadChatStore = getIt.get<ThreadChatStore>();
  final ExplainMessage currentMessage;

  ExplainMessageTile({super.key, required this.currentMessage});

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
                _buildMessage(context),
                const SizedBox(height: 8),
                SupportIconInMessage(
                  textCopy: currentMessage.explain ?? "",
                ),
                const SizedBox(height: 8),
                if (isEnabledSubmission) ...[
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.85),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonSubmissionReview(isEnabled: isEnabledSubmission),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                ]
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildMessage(BuildContext context) {
    if (currentMessage.explain != null && currentMessage.explain!.isEmpty) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.85),
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).colorScheme.buttonYesBgOrText,
          ),
        ),
        child: currentMessage.explain == null
            ? const MessageLoadingResponse()
            : ConvertStringToLatex(rawText: currentMessage.explain!),
      ),
    );
  }
}
