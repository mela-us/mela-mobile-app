import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SkeletonContainer extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final bool isAI;

  const SkeletonContainer._({
    required this.isAI,
    this.width = double.infinity,
    this.height = double.infinity,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    Key? key,
  }) : super(key: key);

  const SkeletonContainer.rounded({
    required isAI,
    required double width,
    required double height,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(12)),
  }) : this._(width: width, height: height, borderRadius: borderRadius, isAI: isAI);

  @override
  Widget build(BuildContext context) => SkeletonAnimation(
        borderRadius: borderRadius,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: isAI
                ? Theme.of(context).colorScheme.buttonYesBgOrText.withOpacity(0.1)
                : Theme.of(context).colorScheme.onTertiary.withOpacity(0.1),
            borderRadius: borderRadius,
          ),
        ),
      );
}
