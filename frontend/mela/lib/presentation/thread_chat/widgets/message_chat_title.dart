import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/assets.dart';
import 'package:mela/domain/entity/message_chat/message_chat.dart';

class MessageChatTitle extends StatelessWidget {
  final MessageChat currentMessage;

  const MessageChatTitle({
    super.key,
    required this.currentMessage,
  });

  @override
  Widget build(BuildContext context) {
    bool isAI = currentMessage.isAI;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment:
            isAI ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Message
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7),
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isAI
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isAI
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey,
                    width: 1,
                  ),
                ),
                child: Text(
                  currentMessage.message,
                  style: Theme.of(context).textTheme.normal.copyWith(
                        color: isAI ? Colors.white : Colors.black,
                      ),
                ),
              ),

              //Support Icons
              if (isAI)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ...[
                      Icon(Icons.thumb_down),
                      Icon(Icons.thumb_up),
                      Icon(Icons.copy)
                    ]
                        .expand((item) => [item, const SizedBox(width: 5)])
                        .toList(),
                  ],
                )
            ],
          ),
        ],
      ),
    );
  }
}
