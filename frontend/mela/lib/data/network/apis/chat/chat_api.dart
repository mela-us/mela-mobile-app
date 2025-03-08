import 'package:mela/data/network/dio_client.dart';
import 'package:mela/domain/entity/message_chat/conversation.dart';
import 'package:mela/domain/entity/message_chat/message_chat.dart';
import 'package:mela/domain/usecase/chat/send_message_chat_usecase.dart';

class ChatApi {
  DioClient _dioClient;
  ChatApi(this._dioClient);

  Future<MessageChat> sendMessageChat(ChatRequestParams params) async {
    print("================================ ở sendMessageAI API");
    await Future.delayed(const Duration(seconds: 2));
    return MessageChat(
        message:
            """This is answer from AI Mela.\nPhân tích đề bài:\nĐề bài yêu cầu điền các số còn thiếu vào dãy số:\n5, 10, 15, ..., 25, ..., 35, ..., 45, 505, 10, 15.\nHướng làm:\n• Xác định công sai hoặc quy luật giữa các số.\n• Tìm công thức tổng quát nếu có.\n• Điền các số còn thiếu dựa trên quy luật.\n• Kiểm tra lại xem dãy số có lặp lại hoặc có phần riêng biệt không.\n• Xác định ý nghĩa của số 505 và số lặp lại ở cuối dãy.""",
        isAI: true);
    // print(
    //     "================================********==================");
    // print("a=: ${a}");n
  }

  Future<Conversation> getConversation(String conversationId) async {
    print("================================ ở getConversation API");
    Future.delayed(const Duration(seconds: 2));
    return Conversation(
        conversationId: "1",
        nameConversation: "NAME Conversation",
        messages: [
          MessageChat(
            message: "ABC",
            isAI: true,
          )
        ]);
  }
}
