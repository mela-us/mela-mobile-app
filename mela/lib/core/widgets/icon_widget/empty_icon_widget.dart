import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';

import '../../../constants/assets.dart';

class EmptyIconWidget extends StatelessWidget {

  final String mainMessage;
  final String secondaryMessage;
  final double offset;

  const EmptyIconWidget({super.key, required this.mainMessage, required this.secondaryMessage, required this.offset});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: offset),
            Image.asset(Assets.empty_icon, width: 150, height: 150),
            const SizedBox(height: 2),
            Text(
              mainMessage,
              style: Theme.of(context).textTheme.subHeading.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
            ),
            Text(
              secondaryMessage,
              style: Theme.of(context).textTheme.subHeading.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
            )
          ],
        ),
      ),
    );
  }
}