import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';

class ChatTokenWidget extends StatelessWidget {
  final int tokenChat;
  const ChatTokenWidget({super.key, required this.tokenChat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.appBackground,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: Colors.orangeAccent,
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/icons/icon_token.png",
            width: 16.0,
            height: 16.0,
            color: Colors.orangeAccent,
          ),
          const SizedBox(width: 4.0),
          Text(
            '$tokenChat',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.orangeAccent, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
