import 'package:flutter/material.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/dimens.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/domain/entity/message_chat/conversation.dart';
import 'package:mela/presentation/chat/store/history_store.dart';
import 'package:mela/presentation/chat/widgets/sidebar_widget.dart';
import 'package:mela/presentation/thread_chat/store/thread_chat_store/thread_chat_store.dart';
import 'package:mela/presentation/thread_chat/widgets/chat_box.dart';
import 'package:mela/utils/routes/routes.dart';

//First look at the ChatScreen
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ThreadChatStore _threadChatStore = getIt.get<ThreadChatStore>();
  final HistoryStore _historyStore = getIt.get<HistoryStore>();
  List<Map<String, dynamic>> messages = [
    {
      "text":
          "Dãy số sau tuân theo một quy luật, hãy điền các số còn thiếu: 5,10,15,...25,...,35,...,45,505, 10, 15",
      "isUser": true
    },
    {
      "text":
          "Phân tích đề bài:\nĐề bài yêu cầu điền các số còn thiếu vào dãy số:\n5, 10, 15, ..., 25, ..., 35, ..., 45, 505, 10, 15",
      "isUser": false
    },
    {
      "text":
          "Hướng làm:\n• Xác định công sai hoặc quy luật giữa các số.\n• Tìm công thức tổng quát nếu có.\n• Điền các số còn thiếu dựa trên quy luật.\n• Kiểm tra lại xem dãy số có lặp lại hoặc có phần riêng biệt không.\n• Xác định ý nghĩa của số 505 và số lặp lại ở cuối dãy.",
      "isUser": false
    },
  ];

  List<String> suggestions = [
    "Chụp bài giải",
    "Gợi ý làm bài",
    "Quy luật của dãy số là gì?",
    "Cách tìm số còn thiếu trong dãy số?",
    "Cách tìm công thức tổng quát?",
    "Kết thúc"
  ];

  bool isSelected = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          backgroundColor: Theme.of(context).colorScheme.appBackground,
          elevation: 0,
          title: _buildTitle(context),
        ),
        backgroundColor: Theme.of(context).colorScheme.appBackground,
        body: SingleChildScrollView(
          child: _buildDefaultBody(context),
        ));
  }

  //Build component:------------------------------------------------------------
  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Dimens.horizontal_padding),
      child: Row(
        children: [
          _buildHistoryButton(context),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: _buildTextTitle(context)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultBody(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      // padding: EdgeInsets.fromLTRB(16.0, (screenHeight - 610) * 0.5, 16.0, 10),
      padding: const EdgeInsets.fromLTRB(16.0, 40, 16.0, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(Icons.waving_hand,
              color: Theme.of(context).colorScheme.buttonYesBgOrText, size: 48),
          const SizedBox(height: 15),
          Row(
            children: [
              Text(
                "Xin chào!",
                style: Theme.of(context)
                    .textTheme
                    .bigTitle
                    .copyWith(color: Theme.of(context).colorScheme.headTitle),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
              "Mình là Mela AI, trợ giảng toán của bạn.\nBạn cần mình giúp giải quyết vấn đề gì nào?",
              style: Theme.of(context)
                  .textTheme
                  .aiExplainStyle
                  .copyWith(color: Theme.of(context).colorScheme.secondary)),
          const SizedBox(height: 15),
          ChatBox(isFirstChatScreen: true),
          const SizedBox(height: 15),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildListItem("Cách giải phương trình bậc 2 một ẩn"),
              _buildListItem("Hệ thức Vi-et là gì?"),
              _buildListItem("Hướng dẫn mình giải bài toán này"),
              _buildListItem("Nhận xét bài làm của mình"),
            ],
          ),
        ],
      ),
    );
  }

  //Build items:----------------------------------------------------------------
  Widget _buildHistoryButton(BuildContext context) {
    return GestureDetector(
        onTap: () => {
              // Show sidebar
              showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: "Sidebar",
                  transitionDuration: const Duration(milliseconds: 300),
                  transitionBuilder: (context, anim1, anim2, child) {
                    return ClipRect(
                      child: SlideTransition(
                        position: Tween(
                                begin: const Offset(-1, 0),
                                end: const Offset(0, 0))
                            .animate(anim1),
                        child: child,
                      ),
                    );
                  },
                  pageBuilder: (context, anim1, anim2) {
                    return const Align(
                        alignment: Alignment.centerLeft,
                        // Sidebar xuất hiện từ bên phải
                        child: Material(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                          child: SidebarWidget(),
                        )); // Sidebar
                  }),
              // Call api
              _historyStore.getConvHistory()
            },
        child: SizedBox(
          width: 30,
          height: 30,
          child: Icon(
            Icons.history_rounded,
            size: 30,
            color: Theme.of(context).colorScheme.textInBg1,
          ),
        ));
  }

  Widget _buildTextTitle(BuildContext context) {
    return Center(
      child: Text(
        "Mela AI",
        style: Theme.of(context)
            .textTheme
            .heading
            .copyWith(color: Theme.of(context).colorScheme.textInBg1),
        textAlign: TextAlign.center,
      ),
    );
  }

  //List Items first hint chat
  Widget _buildListItem(String title) {
    return GestureDetector(
      onTap: () {
        print("Clicked");
        _threadChatStore.setConversation(Conversation(
            conversationId: "",
            messages: [],
            hasMore: false,
            levelConversation: LevelConversation.UNIDENTIFIED,
            dateConversation: DateTime.now(),
            nameConversation: ""));

        Navigator.of(context).pushNamed(Routes.threadChatScreen);
        _threadChatStore.sendChatMessage(title, []);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
              width: 0.1,
            ),
            bottom: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
              width: 0.1,
            ),
          ),
        ),
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // Bỏ bo góc
          ),
          color: Colors.white.withOpacity(0.9),
          margin: const EdgeInsets.symmetric(vertical: 0),
          child: ListTile(
            title: Text(title,
                style: Theme.of(context)
                    .textTheme
                    .promptTitleStyle
                    .copyWith(color: Colors.black)),
            trailing: Icon(Icons.send,
                size: 14, color: Theme.of(context).colorScheme.sendButton),
          ),
        ),
      ),
    );
  }

  void onOpenConversation() {
    // setState(() {
    //   isSelected = true;
    // });
    // print("Reached");
  }
}
