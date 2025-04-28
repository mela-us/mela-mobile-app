import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/core/widgets/showcase_custom.dart';
import 'package:mela/data/sharedpref/shared_preference_helper.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/domain/entity/message_chat/initial_message.dart';
import 'package:mela/presentation/thread_chat/store/chat_box_store/chat_box_store.dart';
import 'package:mela/presentation/thread_chat/store/thread_chat_store/thread_chat_store.dart';
import 'package:mela/presentation/thread_chat/widgets/convert_string_to_latex.dart';
import 'package:mela/presentation/thread_chat/widgets/message_type_tile/button_submission_review.dart';
import 'package:mela/presentation/thread_chat/widgets/message_type_tile/support_icon_in_message.dart';
import 'package:showcaseview/showcaseview.dart';

class InitialMessageTile extends StatefulWidget {
  final InitialMessage currentMessage;

  InitialMessageTile({super.key, required this.currentMessage});

  @override
  State<InitialMessageTile> createState() => _InitialMessageTileState();
}

class _InitialMessageTileState extends State<InitialMessageTile> {
  final ThreadChatStore _threadChatStore = getIt.get<ThreadChatStore>();
  final SharedPreferenceHelper _sharedPreferenceHelper =
      getIt.get<SharedPreferenceHelper>();

  final ChatBoxStore _chatBoxStore = getIt.get<ChatBoxStore>();
  final GlobalKey _keyRelativeTerm = GlobalKey();
  final GlobalKey _keySubmitAnswer = GlobalKey();
  BuildContext? showCaseContext;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 300), () async {
        final isFirstTimeIntitialMessage =
            await _sharedPreferenceHelper.isFirstTimeIntitialMessage;
        if (mounted && showCaseContext != null && isFirstTimeIntitialMessage) {
          ShowCaseWidget.of(showCaseContext!).startShowCase([
            _keyRelativeTerm,
            _keySubmitAnswer,
          ]);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(onFinish: () {
      print("=============>Finish showcase in InitialMessageTile");
      _sharedPreferenceHelper.saveIsFirstTimeIntitialMessage(false);
    }, builder: (context) {
      showCaseContext = context;
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
                  ShowcaseCustom(
                      keyWidget: _keyRelativeTerm,
                      title: "Các từ khóa liên quan",
                      isHideActionWidget: true,
                      description:
                          "Chọn nhanh các từ khóa liên quan để MELA giải thích chi tiết nhanh chóng!",
                      child: _buildRelativeTerms(context)),
                  const SizedBox(height: 8),

                  // Support Icons: Like, unlike, copy
                  SupportIconInMessage(
                    textCopy: _buildFullMessageText(),
                  ),

                  const SizedBox(height: 8),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.85,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ShowcaseCustom(
                          keyWidget: _keySubmitAnswer,
                          title: "Nộp bài",
                          description:
                              "Sau khi xem các hướng dẫn chi tiết, bạn có thể ấn nộp bài để MELA kiểm tra bài làm của bạn nhé!",
                          child: ButtonSubmissionReview(
                            isEnabled: isEnabledSubmission,
                          ),
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
          ConvertStringToLatex(rawText: widget.currentMessage.solutionMethod),

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

  String _buildFullMessageText() {
    StringBuffer fullText = StringBuffer();

    // Solution Method
    fullText.writeln("Phương pháp giải:");
    fullText.writeln(widget.currentMessage.solutionMethod);
    fullText.writeln();

    // Analysis
    fullText.writeln("Phân tích:");
    fullText.writeln(widget.currentMessage.analysis);
    fullText.writeln();

    // Steps
    fullText.writeln("Các bước thực hiện:");
    for (int i = 0; i < widget.currentMessage.steps.length; i++) {
      fullText.writeln("${widget.currentMessage.steps[i].title}");
      fullText.writeln("${widget.currentMessage.steps[i].description}");
      if (i < widget.currentMessage.steps.length - 1) {
        fullText.writeln("---");
      }
    }
    fullText.writeln();

    // Advice
    fullText.writeln("Lời khuyên:");
    fullText.writeln(widget.currentMessage.advice);
    fullText.writeln();

    // Relative Terms
    fullText.writeln("Từ khóa liên quan:");
    fullText.writeln(widget.currentMessage.relativeTerms.join(", "));

    return fullText.toString();
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
          ConvertStringToLatex(rawText: widget.currentMessage.analysis),
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
          ...widget.currentMessage.steps.asMap().entries.map((entry) {
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
                  if (index != widget.currentMessage.steps.length - 1)
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
          ConvertStringToLatex(rawText: widget.currentMessage.advice),
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
            children: widget.currentMessage.relativeTerms
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
