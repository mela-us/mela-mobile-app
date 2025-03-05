import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';

class ThreadChatScreen extends StatefulWidget {
  const ThreadChatScreen({super.key});

  @override
  State<ThreadChatScreen> createState() => _ThreadChatScreenState();
}

class _ThreadChatScreenState extends State<ThreadChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const Center(child: Text("Thread Chat Screen")),
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
        ));
  }
}
