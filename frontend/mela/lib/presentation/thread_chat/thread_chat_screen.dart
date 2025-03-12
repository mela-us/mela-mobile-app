import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/thread_chat/store/thread_chat_store/thread_chat_store.dart';
import 'package:mela/presentation/thread_chat/widgets/chat_box.dart';
import 'package:mela/presentation/thread_chat/widgets/message_chat_title.dart';

class ThreadChatScreen extends StatefulWidget {
  ThreadChatScreen({super.key});

  @override
  State<ThreadChatScreen> createState() => _ThreadChatScreenState();
}

class _ThreadChatScreenState extends State<ThreadChatScreen> {
  final ThreadChatStore _threadChatStore = getIt.get<ThreadChatStore>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Future.delayed(Duration(milliseconds: 100), _scrollToBottom));
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastEaseInToSlowEaseOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            _threadChatStore.clearConversation();
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              _threadChatStore.clearConversation();
            },
            icon: Icon(
              Icons.add_circle_outline,
              color: Theme.of(context).colorScheme.buttonYesBgOrText,
            ),
          )
        ],
        title: Text(
          "Thread Chat",
          style: Theme.of(context)
              .textTheme
              .heading
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: Observer(builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
        return Column(
          children: [
            Expanded(
              child: _threadChatStore.currentConversation?.messages == null
                  ? const Center(
                      child: Text("Start a conversation"),
                    )
                  : SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: _threadChatStore.currentConversation!.messages
                            .map((message) =>
                                MessageChatTitle(currentMessage: message))
                            .toList(),
                      ),
                    ),
            ),
            ChatBox()
          ],
        );
      }),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
