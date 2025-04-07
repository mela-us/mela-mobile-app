import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/assets.dart';
import 'package:mela/domain/entity/message_chat/review_message.dart';
import 'package:mela/presentation/thread_chat/widgets/convert_string_to_latex.dart';
import 'package:mela/presentation/thread_chat/widgets/message_type_tile/button_solution_ai.dart';
import 'package:mela/presentation/thread_chat/widgets/message_type_tile/support_icon_in_message.dart';

class ReviewMessageTile extends StatelessWidget {
  final ReviewMessage currentMessage;

  const ReviewMessageTile({super.key, required this.currentMessage});

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
              if (currentMessage.submissionSummary != null)
                _buildSubmissionSummary(context),
              if (currentMessage.submissionSummary != null)
                const SizedBox(height: 10),

              // Guidance
              if (currentMessage.guidance != null) _buildGuidance(context),
              if (currentMessage.guidance != null) const SizedBox(height: 10),

              // Encouragement
              if (currentMessage.encouragement != null)
                _buildEncouragement(context),
              if (currentMessage.encouragement != null)
                const SizedBox(height: 10),

              // Areas for Improvement
              if (currentMessage.areasForImprovement != null)
                _buildAreasForImprovement(context),
              if (currentMessage.areasForImprovement != null)
                const SizedBox(height: 10),

              // Support Icons: Like, unlike, copy
              const SupportIconInMessage(),
              const SizedBox(height: 8),

              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.85,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonSolutionAi(isEnabled: true),
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
          ConvertStringToLatex(rawText: currentMessage.submissionSummary!),
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
          ConvertStringToLatex(rawText: currentMessage.guidance!),
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
          ConvertStringToLatex(rawText: currentMessage.encouragement!),
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
          ConvertStringToLatex(rawText: currentMessage.areasForImprovement!),
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
        color: currentMessage.status == ReviewStatus.correct
            ? Colors.green[50]
            : Colors.red[50],
      ),
      child: Row(
        children: [
          Icon(
            currentMessage.status == ReviewStatus.correct
                ? Icons.check_circle
                : Icons.cancel,
            color: currentMessage.status == ReviewStatus.correct
                ? Colors.green[700]
                : Colors.red[700],
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            "Kết quả: ${currentMessage.status == ReviewStatus.correct ? 'Đúng' : 'Sai'}",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.65,
                  color: currentMessage.status == ReviewStatus.correct
                      ? Colors.green[700]
                      : Colors.red[700],
                ),
          ),
        ],
      ),
    );
  }
}
