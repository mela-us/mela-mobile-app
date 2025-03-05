import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mela/constants/app_theme.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/thread_chat/store/chat_box_store/chat_box_store.dart';
import 'package:mela/presentation/thread_chat/widgets/support_item.dart';

class ChatBox extends StatefulWidget {
  final Function() onSendMessage;
  ChatBox({super.key, required this.onSendMessage});

  @override
  _ChatBoxState createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  final TextEditingController _controller = TextEditingController();
  final _chatBoxStore = getIt.get<ChatBoxStore>();

  @override
  void initState() {
    super.initState();
    _controller.addListener(onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  //Event to display/hide the accessibility icons
  void onTextChanged() {
    if (_controller.text.isNotEmpty && _chatBoxStore.isLoading == false) {
      _chatBoxStore.setShowSendIcon(true);
    } else {
      _chatBoxStore.setShowSendIcon(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: Colors.white54,
        border: Border.all(color: Colors.grey, width: 0.8),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          //TextField
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    controller: _controller,
                    maxLines: 3,
                    minLines: 1,
                    decoration: const InputDecoration(
                      hintText: "Type a message",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Observer(
                builder: (_) {
                  return _chatBoxStore.showSendIcon
                      ? IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            widget.onSendMessage();
                            _controller.clear();
                          },
                        )
                      : const SizedBox();
                },
              ),
            ],
          ),
          const SizedBox(height: 5),

          //Support Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  child: SupportItem(
                      icon: Icons.functions,
                      textSupport: "Công thức",
                      onTap: () {})),
              Expanded(
                  child: SupportItem(
                      icon: Icons.image,
                      textSupport: "Hình ảnh",
                      onTap: () {})),
              Expanded(
                  child: SupportItem(
                      icon: Icons.camera_alt,
                      textSupport: "Camera",
                      onTap: () {})),
            ],
          ),
        ],
      ),
    );
  }
}
