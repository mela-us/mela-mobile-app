import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:shimmer/shimmer.dart';

class AnimationHelper {
  static Duration getAnimationDurationOfIndex(int index) {
    Duration duration = 6500.ms;
    if (index % 2 == 0) {
      for (int i = 0; i < index; i++) {
        duration = duration - 100.ms;
      }
    }
    else {
      for (int i = 0; i < index; i++) {
        duration = duration + 100.ms;
      }
    }
    return duration;
  }

  static Duration getAnimationDelayOfIndex(int index) {
    Duration duration = 1000.ms;
    for (int i = 0; i < index; i++) {
      duration = duration + 600.ms;
    }
    return duration;
  }

  static Widget buildShimmerPlaceholder(BuildContext context, double width, double height) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.appBackground,
      highlightColor: Theme.of(context).colorScheme.onSecondary,
      direction: ShimmerDirection.ltr,
      period: 1000.ms,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.appBackground,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}