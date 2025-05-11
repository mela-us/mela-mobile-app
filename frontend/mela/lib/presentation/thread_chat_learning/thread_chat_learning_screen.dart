import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/assets.dart';
import 'package:mela/core/widgets/image_progress_indicator.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/domain/entity/message_chat/conversation.dart';
import 'package:mela/domain/entity/message_chat/review_message.dart';
import 'package:mela/presentation/question/store/question_store.dart';
import 'package:mela/presentation/question/store/single_question/single_question_store.dart';
import 'package:mela/presentation/thread_chat/store/chat_box_store/chat_box_store.dart';
import 'package:mela/presentation/thread_chat/store/thread_chat_store/thread_chat_store.dart';
import 'package:mela/presentation/thread_chat/widgets/chat_box.dart';
import 'package:mela/presentation/thread_chat/widgets/list_skeleton.dart';
import 'package:mela/presentation/thread_chat/widgets/message_chat_title.dart';
import 'package:mela/presentation/thread_chat/widgets/message_type_tile/animation_review_tile.dart';
import 'package:mobx/mobx.dart';

import 'store/chat_box_learning_store/chat_box_learning_store.dart';
import 'store/thread_chat_learning_store/thread_chat_learning_store.dart';
import 'widgets/chat_box_learning.dart';

class ThreadChatLearningScreen extends StatefulWidget {
  ThreadChatLearningScreen({super.key});

  @override
  State<ThreadChatLearningScreen> createState() => _ThreadChatLearningScreenState();
}

class _ThreadChatLearningScreenState extends State<ThreadChatLearningScreen> {
  final ThreadChatLearningStore _threadChatLearningStore =
      getIt.get<ThreadChatLearningStore>();
  // final SingleQuestionStore _singleQuestionStore =
  //     getIt.get<SingleQuestionStore>();
  // final QuestionStore _questionStore = getIt<QuestionStore>();
  final ChatBoxLearningStore _chatBoxLearningStore =
      getIt.get<ChatBoxLearningStore>();
  final ScrollController _scrollController = ScrollController();
  late ReactionDisposer disposerSendMessage;
  // late ReactionDisposer disposerGetConversation;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    //For first time go to from history it will scroll to bottom
    // disposerGetConversation = reaction<bool>(
    //   (_) => _threadChatLearningStore.isLoadingGetConversation,
    //   (value) {
    //     if (!value) {
    //       WidgetsBinding.instance
    //           .addPostFrameCallback((_) => _scrollToBottom());
    //     }
    //   },
    // );
    //For send message and get response from AI, it will scroll to bottom
    disposerSendMessage = reaction<bool>(
      (_) => _threadChatLearningStore.isLoading,
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
    // _threadChatLearningStore.getConversation();
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
        !_threadChatLearningStore.isLoadingGetOlderMessages &&
        _threadChatLearningStore.currentConversation.hasMore) {
      double _currentPosition = _scrollController.position.maxScrollExtent;
      // print("=======================>1On Scroll At the top $_currentPosition");

      await _threadChatLearningStore.getOlderMessages();
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
            _threadChatLearningStore.clearConversation();

            _chatBoxLearningStore.setShowCameraIcon(true);
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Observer(builder: (context) {
            return IconButton(
              onPressed: _threadChatLearningStore.isLoadingGetConversation ||
                      _threadChatLearningStore.isLoading
                  ? null
                  : () {
                      _threadChatLearningStore.clearConversation();
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
            _threadChatLearningStore.conversationName,
            style: Theme.of(context)
                .textTheme
                .heading
                .copyWith(color: Theme.of(context).colorScheme.primary),
          );
        }),
      ),
      body: Observer(builder: (context) {
        return _threadChatLearningStore.isLoadingGetConversation
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
                    child: _threadChatLearningStore
                            .currentConversation.messages.isEmpty
                        ? _buildDefaultBodyInNewConversation()
                        : ScrollbarTheme(
                            data: ScrollbarThemeData(
                              thumbColor:
                                  MaterialStateProperty.all(Colors.grey),
                              trackColor:
                                  MaterialStateProperty.all(Colors.yellow),
                              radius: const Radius.circular(20),
                              thickness: MaterialStateProperty.all(4),
                            ),
                            child: Scrollbar(
                              controller: _scrollController,
                              child: SingleChildScrollView(
                                //Must use SingleChildScrollView
                                controller: _scrollController,
                                child: Column(children: [
                                  if (_threadChatLearningStore
                                      .isLoadingGetOlderMessages) ...[
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 8),
                                        child: ListSkeleton(
                                            isReverse: _threadChatLearningStore
                                                .currentConversation
                                                .messages
                                                .first
                                                .isAI))
                                  ],
                                  ..._threadChatLearningStore
                                      .currentConversation.messages
                                      .map((message) => MessageChatTitle(
                                          currentMessage: message))
                                      .toList()
                                ]),
                              ),
                            ),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ChatBoxLearning(),
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
            const SizedBox(height: 15),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // if (_threadChatLearningStore.isGoToFromReview)
                  //   ..._buildAllItemQuestionDefaultForFromReview()
                  // else
                  //   ..._buildAllItemQuestionDefault(),
                  ..._buildAllItemQuestionDefault()
                ],
              ),
            )
          ]),
    );
  }

  List<Widget> _buildAllItemQuestionDefault() {
    return [
      _buildItemHintQuestion("Cách giải phương trình bậc 2 một ẩn?"),
      _buildItemHintQuestion("Hệ thức Vi-et là gì?"),
      _buildItemHintQuestion("Cách giải phương trình bậc 3 một ẩn?"),
      _buildItemHintQuestion("Làm sao để tính số Fibonacci thứ n?"),
    ];
  }

  // List<Widget> _buildAllItemQuestionDefaultForFromReview() {
  //   return [
  //     _buildItemHintQuestionFromReview("Giải thích lại câu hỏi hiện tại", () {
  //       // _threadChatLearningStore.sendChatMessage(
  //       //     "Giải thích lại câu hỏi hiện tại: ${_questionStore.questionList!.questions![_singleQuestionStore.currentIndex].content}",
  //       //     []);
  //     }),
  //   ];
  // }

  Widget _buildItemHintQuestion(String title) {
    return GestureDetector(
      onTap: () {
        _threadChatLearningStore.sendChatMessage(title, []);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        margin: const EdgeInsets.only(right: 10),
        height: 50,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(title,
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .promptTitleStyle
                  .copyWith(color: Colors.black)),
        ),
      ),
    );
  }

  // Widget _buildItemHintQuestionFromReview(String title, Function() onTap) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
  //       margin: const EdgeInsets.only(right: 10),
  //       height: 50,
  //       width: 150,
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         border: Border.all(
  //           color: Colors.grey,
  //         ),
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       child: Center(
  //         child: Text(title,
  //             textAlign: TextAlign.left,
  //             style: Theme.of(context)
  //                 .textTheme
  //                 .promptTitleStyle
  //                 .copyWith(color: Colors.black)),
  //       ),
  //     ),
  //   );
  // }

}
