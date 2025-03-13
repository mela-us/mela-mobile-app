import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/core/widgets/image_progress_indicator.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/thread_chat/store/thread_chat_store/thread_chat_store.dart';
import 'package:mela/presentation/thread_chat/widgets/chat_box.dart';
import 'package:mela/presentation/thread_chat/widgets/message_chat_title.dart';
import 'package:mobx/mobx.dart';

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _threadChatStore.getConversation();
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
          Observer(builder: (context) {
            return IconButton(
              onPressed: _threadChatStore.isLoadingGetConversation
                  ? null
                  : () {
                      _threadChatStore.clearConversation();
                    },
              icon: Icon(
                Icons.add_circle_outline,
                color: Theme.of(context).colorScheme.buttonYesBgOrText,
              ),
            );
          })
        ],
        title: Observer(builder: (context) {
          return Text(
            _threadChatStore.conversationName,
            style: Theme.of(context)
                .textTheme
                .heading
                .copyWith(color: Theme.of(context).colorScheme.primary),
          );
        }),
      ),
      body: Observer(builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
        return _threadChatStore.isLoadingGetConversation
            ? AbsorbPointer(
                absorbing: true,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      color: Theme.of(context)
                          .colorScheme
                          .surface
                          .withOpacity(0.8),
                    ),
                    const RotatingImageIndicator(),
                  ],
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: _threadChatStore.currentConversation.messages.isEmpty
                        ? const Center(
                            child: Text("Start a conversation"),
                          )
                        : ScrollbarTheme(
                            data: ScrollbarThemeData(
                              thumbColor: WidgetStateProperty.all(Colors.grey),
                              trackColor:
                                  WidgetStateProperty.all(Colors.yellow),
                              radius: const Radius.circular(20),
                              thickness: WidgetStateProperty.all(4),
                            ),
                            child: Scrollbar(
                              child: SingleChildScrollView(
                                controller: _scrollController,
                                child: Column(
                                  children: _threadChatStore
                                      .currentConversation.messages
                                      .map((message) => MessageChatTitle(
                                          currentMessage: message))
                                      .toList(),
                                ),
                              ),
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
