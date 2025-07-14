import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/core/widgets/image_progress_indicator.dart';

class MessageLoadingResponse extends StatelessWidget {
  const MessageLoadingResponse({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20, width: 20, child: RotatingImageIndicator()),
          const SizedBox(width: 6),
          Text("Chờ Mela một chút nhé!",
              style: Theme.of(context).textTheme.content.copyWith(
                  color: Colors.grey[600],
                  fontSize: 14,
                  letterSpacing: 0.65,
                  height: 1.65)),
        ],
      ),
    );
  }
}
