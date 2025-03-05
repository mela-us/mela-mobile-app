import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/domain/entity/message_chat/message_chat.dart';
import 'package:mela/presentation/thread_chat/widgets/chat_box.dart';
import 'package:mela/presentation/thread_chat/widgets/message_chat_title.dart';

class ThreadChatScreen extends StatelessWidget {
  const ThreadChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: //AppBar
          AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          "Thread Chat",
          style: Theme.of(context)
              .textTheme
              .heading
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              //Chat Messages
              ...List.generate(25, (index) {
                return MessageChatTitle(
                    currentMessage: MessageChat(
                        message:
                            "HelloHelloHelloHelloHello HelloHelloHelloHelloHelloHelloHelloHelloHe lloHelloHelloHelloHelloHelloHelloHelloHelloHello",
                        isAI: index % 2 == 0));
              }).toList(),
            ],
          )),
          ChatBox(onSendMessage: () {})
        ],
      ),
    );
  }
}
