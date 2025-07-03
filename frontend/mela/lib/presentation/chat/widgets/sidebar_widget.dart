import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/constants/dimens.dart';
import 'package:mela/constants/enum.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/domain/entity/chat/history_item.dart';
import 'package:mela/domain/entity/message_chat/conversation.dart';
import 'package:mela/presentation/chat/store/history_store.dart';
import 'package:mela/presentation/thread_chat/store/thread_chat_store/thread_chat_store.dart';
import 'package:mela/presentation/thread_chat/thread_chat_screen.dart';
import 'package:mela/utils/routes/routes.dart';

class SidebarWidget extends StatefulWidget {
  const SidebarWidget({super.key});
  @override
  State<SidebarWidget> createState() => _SidebarWidgetState();
}

class _SidebarWidgetState extends State<SidebarWidget> {
  final _threadChatStore = getIt.get<ThreadChatStore>();
  final _historyStore = getIt.get<HistoryStore>();

  Conversation testConversation = Conversation(
    conversationId: "conv_001",
    dateConversation: DateTime.now(),
    hasMore: false,
    levelConversation: LevelConversation.UNIDENTIFIED,
    nameConversation: "Conversation from history",
    messages: [],
  );

  final Map<String, bool> isExpanded = {
    "Hôm nay": false,
    "Hôm qua": true,
    "Thứ Sáu, 28/02": true,
  };

  final List<String> historyItems = [
    "Chu vi hình tròn",
    "Tìm quy luật dãy số",
    "Phép cộng số có hai chữ số có nhớ trying to make this line overflow",
    "Quy luật hình học",
    "Tính chất chia hết cho 7"
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // if (!_historyStore.isLoading) {
    //   _historyStore.getConvHistory();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.75, // Điều chỉnh chiều rộng của sidebar
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.appBackground,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        child: Column(
          children: [
            AppBar(
              title: _buildAppBarTitle(context),
              automaticallyImplyLeading: false,
            ),
            // const SizedBox(height: 30),
            _buildSearchBar(context), // Tìm kiếm
            const SizedBox(height: 10),
            _historyStore.convs.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      widthFactor: double.infinity,
                      child: Text(
                        "Gần đây",
                        style: Theme.of(context).textTheme.subHeading.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  )
                : Container(),

            _buildHistoryList(context),
          ],
        ),
      ),
    );
  }

  //build items-----------------------------------------------------------------
  Widget _buildAppBarTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 24),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        Text(
          "Lịch sử",
          style: Theme.of(context).textTheme.heading.copyWith(
                color: Theme.of(context).colorScheme.textInBg1,
              ),
        ),
        const SizedBox(width: 24),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: TextField(
        style: Theme.of(context).textTheme.aiExplainStyle.copyWith(
              color: Theme.of(context).colorScheme.textInBg1,
            ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: const Icon(Icons.search, size: 20),
          hintText: "Tìm đoạn chat . . .",
          hintStyle: Theme.of(context).textTheme.aiExplainStyle.copyWith(
                color: Theme.of(context).colorScheme.inputHintText,
              ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryList(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Observer(builder: (_) {
          if (_historyStore.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (_historyStore.convs == null || _historyStore.convs.isEmpty) {
              if (kIsWeb) {
                return const Center(
                    child: Text(
                  "Lịch sử không khả dụng cho phiên bản Web",
                  textAlign: TextAlign.center,
                ));
              }
              return const Center(
                child: Text("Chưa có lịch sử nào"),
              );
            } else {
              return ListView.builder(
                itemCount: _historyStore.convs.length,
                itemBuilder: (context, index) {
                  final item = _historyStore.convs[index];
                  return _buildChatHistory(item);
                },
              );
            }
          }
        }),
      ),
    );
  }

  Widget _buildChatHistory(HistoryItem item) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Text title view & detector
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _threadChatStore
                      .setConversation(Conversation.fromHistoryItem(item));

                  // Close sidebar and navigate to chat screen
                  Navigator.of(context).pop();
                  //Push chat screen with transition
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      settings:
                          const RouteSettings(name: Routes.threadChatScreen),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          ThreadChatScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);

                        return ClipRect(
                          child: SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          ),
                        );
                      },
                    ),
                  );
                },
                child: Text(
                  item.title,
                  style: Theme.of(context).textTheme.subTitle.copyWith(
                        fontWeight: FontWeight.w500,
                        color: const Color(0XFF303030),
                      ),
                  maxLines: null,
                  overflow: TextOverflow.clip,
                ),
              ),
            ),

            //Delete button view
            const SizedBox(
              width: 8,
            ),

            IconButton(
                onPressed: () async {
                  //Delete the conversation
                  await _historyStore.deleteConversation(item.conversationId);
                  if (!_historyStore.isUnauthorized) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Đã xóa thành công'),
                      duration: Duration(milliseconds: 500),
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.only(
                          bottom: 20, left: 20, right: 20),
                    ));
                  }
                  await _historyStore.getConvHistory();
                },
                icon: const Icon(
                  Icons.delete,
                  size: 20,
                  color: Colors.grey,
                ))
          ],
        ));
  }
}
