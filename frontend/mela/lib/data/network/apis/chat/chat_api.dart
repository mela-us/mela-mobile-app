import 'package:mela/data/network/dio_client.dart';
import 'package:mela/domain/entity/message_chat/conversation.dart';
import 'package:mela/domain/entity/message_chat/message_chat.dart';
import 'package:mela/domain/usecase/chat/send_message_chat_usecase.dart';

class ChatApi {
  DioClient _dioClient;
  ChatApi(this._dioClient);

  //=======Test
  Conversation _conversation = Conversation(
    conversationId: "2",
    dateConversation: DateTime.now(),
    hasMore: true,
    nameConversation: "Học toán cùng AI From API",
    messages: [
      MessageChat(
        message: "Xin chào! Hôm nay bạn muốn học chủ đề toán nào?",
        isAI: true,
      ),
      MessageChat(
        message:
            "Chào bạn! Mình đang học về số nguyên tố, bạn có thể giải thích không?",
        isAI: false,
      ),
      MessageChat(
        message:
            "Tất nhiên! Số nguyên tố là số tự nhiên lớn hơn 1 và chỉ chia hết cho 1 và chính nó.",
        isAI: true,
      ),
      MessageChat(
        message: "Vậy số 1 có phải là số nguyên tố không?",
        isAI: false,
      ),
      MessageChat(
        message:
            "Không, số 1 không phải là số nguyên tố vì nó chỉ có một ước số là chính nó.",
        isAI: true,
      ),
    ],
  );

  final List<List<MessageChat>> _additionalMessages = [
    [
      MessageChat(
          message: "Làm sao để kiểm tra một số có phải số nguyên tố không?",
          isAI: false),
      MessageChat(
          message:
              "Bạn có thể kiểm tra bằng cách thử chia số đó cho các số từ 2 đến căn bậc hai của nó.",
          isAI: true),
      MessageChat(
          message: "Có thuật toán nào hiệu quả để tìm số nguyên tố không?",
          isAI: false),
      MessageChat(
          message: "Có! Một thuật toán nổi tiếng là Sàng Eratosthenes.",
          isAI: true),
      MessageChat(message: "Bạn có thể cho mình ví dụ không?", isAI: false),
    ],
    [
      MessageChat(
          message:
              "Chắc chắn! Giả sử bạn muốn tìm tất cả số nguyên tố từ 1 đến 30.",
          isAI: true),
      MessageChat(message: "Sau đó thì sao?", isAI: false),
      MessageChat(
          message:
              "Tiếp tục với số nguyên tố tiếp theo là 3 và loại bỏ bội số của nó.",
          isAI: true),
      MessageChat(
          message: "Thật thú vị! Vậy thuật toán này có độ phức tạp ra sao?",
          isAI: false),
      MessageChat(
          message: "Độ phức tạp của nó là O(n log log n), rất nhanh.",
          isAI: true),
    ],
    [
      MessageChat(
          message: "Ngoài số nguyên tố, mình muốn tìm hiểu về dãy Fibonacci.",
          isAI: false),
      MessageChat(
          message:
              "Dãy Fibonacci là một chuỗi số mà mỗi số là tổng của hai số trước đó.",
          isAI: true),
      MessageChat(message: "Làm sao để tính số Fibonacci thứ n?", isAI: false),
      MessageChat(
          message: "Có thể tính bằng đệ quy hoặc quy hoạch động để tối ưu.",
          isAI: true),
      MessageChat(
          message: "Quy hoạch động hoạt động như thế nào?", isAI: false),
    ],
  ];

  int _currentIndex = 0;

  //================================================================

  Future<MessageChat> sendMessageChat(ChatRequestParams params) async {
    print("================================ ở sendMessageAI API");
    await Future.delayed(const Duration(seconds: 4));
    return MessageChat(
        message:
            """This is answer from AI Mela.\nPhân tích đề bài:\nĐề bài yêu cầu điền các số còn thiếu vào dãy số:\n5, 10, 15, ..., 25, ..., 35, ..., 45, 505, 10, 15.\nHướng làm:\n• Xác định công sai hoặc quy luật giữa các số.\n• Tìm công thức tổng quát nếu có.\n• Điền các số còn thiếu dựa trên quy luật.\n• Kiểm tra lại xem dãy số có lặp lại hoặc có phần riêng biệt không.\n• Xác định ý nghĩa của số 505 và số lặp lại ở cuối dãy.""",
        isAI: true);
    // print(
    //     "================================********==================");
    // print("a=: ${a}");n
  }

  Future<Conversation> getConversation(String conversationId) async {
    print("================================ Đang gọi getConversation API");
    await Future.delayed(const Duration(seconds: 4));
    _conversation.messages!.addAll(_additionalMessages[_currentIndex % 3]);
    _currentIndex++;

    return _conversation;
  }
}
