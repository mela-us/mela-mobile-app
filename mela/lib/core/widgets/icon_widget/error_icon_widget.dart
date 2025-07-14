import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';

import '../../../constants/assets.dart';

class ErrorIconWidget extends StatelessWidget {

  final String message;

  const ErrorIconWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 180),
            Image.asset(Assets.error_icon, width: 120, height: 120),
            const SizedBox(height: 2),
            Text(
              message,
              style: Theme.of(context).textTheme.subHeading.copyWith(
                color: Colors.redAccent,
                fontWeight: FontWeight.w800,
              ),
            )
          ],
        ),
      ),
    );
  }
}