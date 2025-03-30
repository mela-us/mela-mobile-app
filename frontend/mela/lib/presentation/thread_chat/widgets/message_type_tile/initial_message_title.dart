import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/assets.dart';
import 'package:mela/domain/entity/message_chat/initial_message.dart';

class InitialMessageTitle extends StatelessWidget {
  final InitialMessage currentMessage;

  const InitialMessageTitle({super.key, required this.currentMessage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // Căn trái cho AI
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Căn trái nội dung
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
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ...[
                    SvgPicture.asset(
                      Assets.like,
                      width: 20,
                    ),
                    const SizedBox(width: 5),
                    SvgPicture.asset(
                      Assets.unlike,
                      width: 20,
                    ),
                    const SizedBox(width: 5),
                    SvgPicture.asset(
                      Assets.copy,
                      width: 20,
                    ),
                  ].expand((item) => [item, const SizedBox(width: 5)]).toList(),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ],
      ),
    );
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
          Text(
            currentMessage.solutionMethod,
            style: Theme.of(context).textTheme.content.copyWith(
                  color: Colors.black,
                  fontSize: 17,
                  letterSpacing: 0.65,
                  height: 1.65,
                ),
          ),
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
          Text(
            currentMessage.analysis,
            style: Theme.of(context).textTheme.content.copyWith(
                  color: Colors.black,
                  fontSize: 17,
                  letterSpacing: 0.65,
                  height: 1.65,
                ),
          ),
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${index + 1}. ",
                      style:
                          const TextStyle(fontSize: 17, letterSpacing: 0.65)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step.title,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.65,
                          ),
                        ),
                        Text(
                          step.description,
                          style: Theme.of(context).textTheme.content.copyWith(
                                color: Colors.black,
                                fontSize: 17,
                                letterSpacing: 0.65,
                                height: 1.65,
                              ),
                        ),
                      ],
                    ),
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
          Text(
            currentMessage.advice,
            style: Theme.of(context).textTheme.content.copyWith(
                  color: Colors.black,
                  fontSize: 17,
                  letterSpacing: 0.65,
                  height: 1.65,
                ),
          ),
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
                      onPressed: () {},
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
                      child: Text(
                        term,
                        style: const TextStyle(
                          fontSize: 14,
                          letterSpacing: 0.65,
                          color: Colors.black,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
