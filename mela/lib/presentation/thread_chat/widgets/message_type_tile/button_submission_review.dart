import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mela/di/service_locator.dart';
import 'package:mela/presentation/thread_chat/store/chat_box_store/chat_box_store.dart';
import 'package:mela/presentation/thread_chat/store/thread_chat_store/thread_chat_store.dart';

class ButtonSubmissionReview extends StatefulWidget {
  final bool isEnabled;

  ButtonSubmissionReview({
    super.key,
    required this.isEnabled,
  });

  @override
  State<ButtonSubmissionReview> createState() => _ButtonSubmissionReviewState();
}

class _ButtonSubmissionReviewState extends State<ButtonSubmissionReview> {
  ChatBoxStore _chatBoxStore = getIt.get<ChatBoxStore>();
  ThreadChatStore _threadChatStore = getIt.get<ThreadChatStore>();

  void _showImagePickerOptions() async {
    if (_threadChatStore.isLoading) {
      return;
    }
    final isSelectedImage = await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Chụp ảnh mới"),
              onTap: () async {
                bool isPicked =
                    await _chatBoxStore.pickImage(ImageSource.camera);
                if (isPicked) {
                  Navigator.of(context).pop(true);
                  return;
                }
                Navigator.of(context).pop(false);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Chọn ảnh từ thư viện"),
              onTap: () async {
                bool isPicked =
                    await _chatBoxStore.pickImage(ImageSource.gallery);
                if (isPicked) {
                  Navigator.of(context).pop(true);
                  return;
                }
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
    if (isSelectedImage == null ||
        isSelectedImage is! bool ||
        isSelectedImage == false) {
      return;
    }
    //If true set isSelectedImageFromSubmission from chatBoxStore to true
    //because when enter review to add image review, it will use api review
    //instead of api send message in function sendMessage in threadChatStore
    _chatBoxStore.setIsSelectedImageFromSubmission(true);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.isEnabled
          ? _showImagePickerOptions
          : () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      "Bạn không thể nộp bài khi Mela đã cung cấp lời giải. Hãy tham khảo lời giải của Mela nhé!"),
                ),
              );
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.isEnabled
            ? const Color.fromARGB(255, 201, 225, 39)
            : Colors.grey[400],
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: widget.isEnabled ? 4 : 0,
        shadowColor: Colors.orange[900]?.withOpacity(0.5),
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
            Icons.send,
            size: 20,
            color: widget.isEnabled ? Colors.white : Colors.grey[200],
          ),
          const SizedBox(width: 8),
          Text(
            "Nộp bài làm",
            style: TextStyle(
              color: widget.isEnabled ? Colors.white : Colors.grey[200],
            ),
          ),
        ],
      ),
    );
  }
}
