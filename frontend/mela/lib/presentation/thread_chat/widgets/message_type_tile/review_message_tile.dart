import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/core/widgets/showcase_custom.dart';
import 'package:mela/data/sharedpref/shared_preference_helper.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/domain/entity/message_chat/review_message.dart';
import 'package:mela/presentation/thread_chat/widgets/convert_string_to_latex.dart';
import 'package:mela/presentation/thread_chat/widgets/message_type_tile/button_solution_ai.dart';
import 'package:mela/presentation/thread_chat/widgets/message_type_tile/support_icon_in_message.dart';
import 'package:showcaseview/showcaseview.dart';

class ReviewMessageTile extends StatefulWidget {
  final ReviewMessage currentMessage;

  const ReviewMessageTile({super.key, required this.currentMessage});

  @override
  State<ReviewMessageTile> createState() => _ReviewMessageTileState();
}

class _ReviewMessageTileState extends State<ReviewMessageTile> {
  BuildContext? showCaseContext;
  GlobalKey _keySolutionAi = GlobalKey();
  final SharedPreferenceHelper _sharedPreferenceHelper =
      getIt.get<SharedPreferenceHelper>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 300), () async {
        final isFirstTimeReviewMessage =
            await _sharedPreferenceHelper.isFirstTimeReviewMessage;
        if (mounted && showCaseContext != null && isFirstTimeReviewMessage) {
          ShowCaseWidget.of(showCaseContext!).startShowCase([
            _keySolutionAi,
          ]);
        }
      });
    });
  }

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
              // Status
              _buildStatus(context),
              const SizedBox(height: 8),
              // Submission Summary
              if (widget.currentMessage.submissionSummary != null)
                _buildSubmissionSummary(context),
              if (widget.currentMessage.submissionSummary != null)
                const SizedBox(height: 10),

              // Guidance
              if (widget.currentMessage.guidance != null)
                _buildGuidance(context),
              if (widget.currentMessage.guidance != null)
                const SizedBox(height: 10),

              // Encouragement
              if (widget.currentMessage.encouragement != null)
                _buildEncouragement(context),
              if (widget.currentMessage.encouragement != null)
                const SizedBox(height: 10),

              // Areas for Improvement
              if (widget.currentMessage.areasForImprovement != null)
                _buildAreasForImprovement(context),
              if (widget.currentMessage.areasForImprovement != null)
                const SizedBox(height: 10),

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
                    ShowCaseWidget(onFinish: () {
                      _sharedPreferenceHelper
                          .saveIsFirstTimeReviewMessage(false);
                    }, builder: (context) {
                      showCaseContext = context;

                      return ShowcaseCustom(
                          keyWidget: _keySolutionAi,
                          isHideActionWidget: true,
                          title: "Đáp án từ MELA",
                          description: "Chọn để xem hướng dẫn chi tiết từ Mela",
                          child: ButtonSolutionAi(isEnabled: true));
                      //   return Showcase(
                      //       key: _keySolutionAi,
                      //       description: "Giai thich solution cua AI",
                      //       title: "Loi giai cua Mela",
                      //       child: ButtonSolutionAi(isEnabled: true));
                      // }
                      // // );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ],
      ),
    );
  }

  // Submission Summary Container
  Widget _buildSubmissionSummary(BuildContext context) {
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
            "Tóm tắt bài làm:",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.65,
                  color: Colors.blue[700], // Màu xanh đậm
                ),
          ),
          const SizedBox(height: 5),
          ConvertStringToLatex(
              rawText: widget.currentMessage.submissionSummary!),
          // Text(
          //   currentMessage.submissionSummary!,
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

  // Guidance Container
  Widget _buildGuidance(BuildContext context) {
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
            "Hướng dẫn:",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.65,
                  color: Colors.green[700], // Màu xanh lá đậm
                ),
          ),
          const SizedBox(height: 5),
          ConvertStringToLatex(rawText: widget.currentMessage.guidance!),
          // Text(
          //   currentMessage.guidance!,
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

  // Encouragement Container
  Widget _buildEncouragement(BuildContext context) {
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
            "Động viên:",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.65,
                  color: Colors.yellow[800], // Màu vàng đậm
                ),
          ),
          const SizedBox(height: 5),
          ConvertStringToLatex(rawText: widget.currentMessage.encouragement!),
          // Text(
          //   currentMessage.encouragement!,
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

  // Areas for Improvement Container
  Widget _buildAreasForImprovement(BuildContext context) {
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
            "Điểm cần cải thiện:",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.65,
                  color: Colors.purple[700], // Màu tím đậm
                ),
          ),
          const SizedBox(height: 5),
          ConvertStringToLatex(
              rawText: widget.currentMessage.areasForImprovement!),
          // Text(
          //   currentMessage.areasForImprovement!,
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

  // Status Container
  Widget _buildStatus(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.85,
      ),
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border:
            Border.all(color: Theme.of(context).colorScheme.buttonYesBgOrText),
        color: widget.currentMessage.status == ReviewStatus.correct
            ? Colors.green[50]
            : Colors.red[50],
      ),
      child: Row(
        children: [
          Icon(
            widget.currentMessage.status == ReviewStatus.correct
                ? Icons.check_circle
                : Icons.cancel,
            color: widget.currentMessage.status == ReviewStatus.correct
                ? Colors.green[700]
                : Colors.red[700],
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            "Kết quả: ${widget.currentMessage.status == ReviewStatus.correct ? 'Đúng' : 'Sai'}",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.65,
                  color: widget.currentMessage.status == ReviewStatus.correct
                      ? Colors.green[700]
                      : Colors.red[700],
                ),
          ),
        ],
      ),
    );
  }

  String _buildFullMessageText() {
    StringBuffer fullText = StringBuffer();

    // Status
    fullText.writeln("Kết quả:");
    fullText.writeln(
        widget.currentMessage.status == ReviewStatus.correct ? 'Đúng' : 'Sai');
    fullText.writeln();

    // Submission Summary
    if (widget.currentMessage.submissionSummary != null) {
      fullText.writeln("Tóm tắt bài làm:");
      fullText.writeln(widget.currentMessage.submissionSummary);
      fullText.writeln();
    }

    // Guidance
    if (widget.currentMessage.guidance != null) {
      fullText.writeln("Hướng dẫn:");
      fullText.writeln(widget.currentMessage.guidance);
      fullText.writeln();
    }

    // Encouragement
    if (widget.currentMessage.encouragement != null) {
      fullText.writeln("Động viên:");
      fullText.writeln(widget.currentMessage.encouragement);
      fullText.writeln();
    }

    // Areas for Improvement
    if (widget.currentMessage.areasForImprovement != null) {
      fullText.writeln("Điểm cần cải thiện:");
      fullText.writeln(widget.currentMessage.areasForImprovement);
    }

    return fullText.toString();
  }
}
