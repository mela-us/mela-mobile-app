import 'package:flutter/material.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/thread_chat/store/chat_box_store/chat_box_store.dart';
import 'package:mela/presentation/thread_chat/store/thread_chat_store/thread_chat_store.dart';

class ButtonSolutionAi extends StatelessWidget {
  final bool isEnabled;
  ThreadChatStore _threadChatStore = getIt.get<ThreadChatStore>();
  ChatBoxStore _chatBoxStore = getIt.get<ChatBoxStore>();
  ButtonSolutionAi({
    super.key,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled
          ? () async {
              if (_threadChatStore.isLoading) {
                return;
              }
              await _threadChatStore
                  .sendMessageGetSolution("Đưa cho mình lời giải hoàn chỉnh");
              //Using for while loading response user enter new message availale
              if (_chatBoxStore.contentMessage.isNotEmpty ||
                  _chatBoxStore.images.isNotEmpty) {
                _chatBoxStore.setShowSendIcon(true);
              }
            }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnabled
            ? const Color.fromARGB(255, 39, 174, 96)
            : Colors.grey[400],
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: isEnabled ? 6 : 0,
        shadowColor: Colors.green[900]?.withOpacity(0.4),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.lightbulb_outline,
            size: 20,
            color: isEnabled ? Colors.white : Colors.grey[200],
          ),
          const SizedBox(width: 8),
          Text(
            "Lời giải của Mela",
            style: TextStyle(
              color: isEnabled ? Colors.white : Colors.grey[200],
            ),
          ),
        ],
      ),
    );
  }
}
