import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/assets.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/question/store/single_question/single_question_store.dart';
import 'package:mela/presentation/thread_chat/widgets/chat_token_widget.dart';
import 'package:mela/presentation/thread_chat/widgets/message_chat_title.dart';
import 'package:mobx/mobx.dart';

import 'store/chat_box_learning_pdf_store/chat_box_learning_pdf_store.dart';
import 'store/thread_chat_learning_pdf_store/thread_chat_learning_pdf_store.dart';
import 'widgets/chat_box_learning_pdf.dart';

class ThreadChatLearningPdfScreen extends StatefulWidget {
  ThreadChatLearningPdfScreen({super.key});

  @override
  State<ThreadChatLearningPdfScreen> createState() =>
      _ThreadChatLearningPdfScreenState();
}

class _ThreadChatLearningPdfScreenState
    extends State<ThreadChatLearningPdfScreen> {
  final ThreadChatLearningPdfStore _threadChatLearningPdfStore =
      getIt.get<ThreadChatLearningPdfStore>();
  final ChatBoxLearningPdfStore _chatBoxLearningPdfStore =
      getIt.get<ChatBoxLearningPdfStore>();
  final ScrollController _scrollController = ScrollController();
  late ReactionDisposer disposerSendMessage;
  // late ReactionDisposer disposerGetConversation;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    //For first time go to from history it will scroll to bottom
    // disposerGetConversation = reaction<bool>(
    //   (_) => _threadChatLearningPdfStore.isLoadingGetConversation,
    //   (value) {
    //     if (!value) {
    //       WidgetsBinding.instance
    //           .addPostFrameCallback((_) => _scrollToBottom());
    //     }
    //   },
    // );
    //For send message and get response from AI, it will scroll to bottom
    disposerSendMessage = reaction<bool>(
      (_) => _threadChatLearningPdfStore.isLoading,
      (value) {
        //not need to check value ==true because it must always loading when isLoading change
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
      },
    );

    //For animation review message
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // _threadChatLearningPdfStore.getConversation();
  }

  @override
  void dispose() {
    disposerSendMessage();
    _scrollController.dispose();
    super.dispose();
  }

//For scroll at the top and loading get older messages
  void _onScroll() async {
    if (_scrollController.position.pixels <= 0 &&
        !_threadChatLearningPdfStore.isLoadingGetOlderMessages &&
        _threadChatLearningPdfStore.currentConversation.hasMore) {
      double _currentPosition = _scrollController.position.maxScrollExtent;
      // print("=======================>1On Scroll At the top $_currentPosition");
      if (_scrollController.position.pixels <= 0) {
        //Chờ loading xong thì mới scroll
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          double newPosition = _scrollController.position.maxScrollExtent -
              _currentPosition -
              50;
          // print("=======================>1On Scroll At the top $newPosition");
          await _scrollController.animateTo(
            newPosition,
            duration: const Duration(milliseconds: 5),
            curve: Curves.fastEaseInToSlowEaseOut,
          );
        });
      }
    }
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
            _chatBoxLearningPdfStore.setShowCameraIcon(true);
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Observer(builder: (context) {
            return ChatTokenWidget(
                tokenChat: _threadChatLearningPdfStore.tokenChat);
          }),
          Observer(builder: (context) {
            return IconButton(
              onPressed: _threadChatLearningPdfStore.isLoadingGetConversation ||
                      _threadChatLearningPdfStore.isLoading
                  ? null
                  : () {
                      _threadChatLearningPdfStore.clearConversation();
                    },
              icon: Icon(
                Icons.add_circle_outline,
                color: Theme.of(context).colorScheme.buttonYesBgOrText,
              ),
            );
          })
        ],
        title: Text(
          "Bài giảng ${_threadChatLearningPdfStore.currentPdf.dividedLectureName}",
          style: Theme.of(context)
              .textTheme
              .heading
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: Observer(builder: (context) {
        return Column(
          children: [
            Expanded(
              child: _threadChatLearningPdfStore
                      .currentConversation.messages.isEmpty
                  ? _buildDefaultBodyInNewConversation()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ScrollbarTheme(
                        data: ScrollbarThemeData(
                          thumbColor: MaterialStateProperty.all(Colors.grey),
                          trackColor: MaterialStateProperty.all(Colors.yellow),
                          radius: const Radius.circular(20),
                          thickness: MaterialStateProperty.all(4),
                        ),
                        child: Scrollbar(
                          controller: _scrollController,
                          child: SingleChildScrollView(
                            //Must use SingleChildScrollView
                            controller: _scrollController,
                            child: Column(children: [
                              ..._threadChatLearningPdfStore
                                  .currentConversation.messages
                                  .map((message) =>
                                      MessageChatTitle(currentMessage: message))
                                  .toList()
                            ]),
                          ),
                        ),
                      ),
                    ),
            ),
            const Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 8, right: 8),
              child: ChatBoxLearningPdf(),
            )
          ],
        );
      }),
    );
  }

  Widget _buildDefaultBodyInNewConversation() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.nav_chat,
                  width: 48,
                  height: 48,
                  color: Theme.of(context).colorScheme.buttonYesBgOrText,
                ),
                const SizedBox(width: 10),
                Text(
                  "Xin chào!",
                  style: Theme.of(context).textTheme.bigTitle.copyWith(
                      color: Theme.of(context).colorScheme.headTitle,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    "Mình là Mela AI, trợ giảng toán của bạn.\nBạn cần mình giúp giải quyết vấn đề gì nào?",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.aiExplainStyle.copyWith(
                        color: Theme.of(context).colorScheme.secondary)),
              ],
            ),
          ]),
    );
  }
}
