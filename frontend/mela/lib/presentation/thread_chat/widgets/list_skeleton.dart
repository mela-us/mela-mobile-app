import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/presentation/thread_chat/widgets/skeleton_container.dart';

class ListSkeleton extends StatelessWidget {
  final bool isReverse;
  const ListSkeleton({super.key, this.isReverse = false});

  Widget _buildAiSkeleton(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;

    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
                color: Theme.of(context).colorScheme.buttonYesBgOrText),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonContainer.rounded(
                isAI: true,
                width: widthDevice * 0.6,
                height: 30.0,
                borderRadius: BorderRadius.circular(8.0),
              ),
              const SizedBox(height: 6.0),
              SkeletonContainer.rounded(
                isAI: true,
                width: widthDevice * 0.4,
                height: 16.0,
                borderRadius: BorderRadius.circular(4.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserSkeleton(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;

    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context)
                    .colorScheme
                    .buttonYesBgOrText
                    .withOpacity(0.6),
                Theme.of(context)
                    .colorScheme
                    .buttonYesBgOrText
                    .withOpacity(0.9),
              ],
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SkeletonContainer.rounded(
                isAI: false,
                width: widthDevice * 0.6,
                height: 30.0,
                borderRadius: BorderRadius.circular(8.0),
              ),
              const SizedBox(height: 6.0),
              SkeletonContainer.rounded(
                isAI: false,
                width: widthDevice * 0.4,
                height: 16.0,
                borderRadius: BorderRadius.circular(4.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final listSkeleton = [
      _buildAiSkeleton(context),
      const SizedBox(height: 16.0),
      _buildUserSkeleton(context),
    ];

    return Column(
      children: isReverse ? listSkeleton : listSkeleton.reversed.toList(),
    );
  }
}
