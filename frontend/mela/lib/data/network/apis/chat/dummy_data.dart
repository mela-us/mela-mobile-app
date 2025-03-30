import 'package:mela/domain/entity/message_chat/message_chat.dart';
import 'package:mela/domain/entity/message_chat/normal_message.dart';

import '../../../../domain/entity/message_chat/conversation.dart';



//Test1
Conversation conversation1 = Conversation(
  conversationId: "2",
  dateConversation: DateTime.now(),
  hasMore: true,
  nameConversation: "Học toán cùng AI From API",
  messages: [
    NormalMessage(
      text: "Xin chào! Hôm nay bạn muốn học chủ đề toán nào?",
      isAI: true,
    ),
    NormalMessage(
      text:
          "Chào bạn! Mình đang học về số nguyên tố, bạn có thể giải thích không?",
      isAI: false,
    ),
    NormalMessage(
      text:
          "Tất nhiên! Số nguyên tố là số tự nhiên lớn hơn 1 và chỉ chia hết cho 1 và chính nó.",
      isAI: true,
    ),
    NormalMessage(
      text: "Vậy số 1 có phải là số nguyên tố không?",
      isAI: false,
    ),
    NormalMessage(
      text:
          "Không, số 1 không phải là số nguyên tố vì nó chỉ có một ước số là chính nó.",
      isAI: true,
    ),
  ],
);

final List<List<MessageChat>> additionalMessages1 = [
  [
    NormalMessage(
        text: "Làm sao để kiểm tra một số có phải số nguyên tố không?",
        isAI: false),
    NormalMessage(
        text:
            "Bạn có thể kiểm tra bằng cách thử chia số đó cho các số từ 2 đến căn bậc hai của nó.",
        isAI: true),
    // NormalMessage(
    //     message: "Có thuật toán nào hiệu quả để tìm số nguyên tố không?",
    //     isAI: false),
    // NormalMessage(
    //     message: "Có! Một thuật toán nổi tiếng là Sàng Eratosthenes.",
    //     isAI: true),
    // NormalMessage(message: "Bạn có thể cho mình ví dụ không?", isAI: false),
  ],
  [
    NormalMessage(
        text:
            "Chắc chắn! Giả sử bạn muốn tìm tất cả số nguyên tố từ 1 đến 30.",
        isAI: true),
    NormalMessage(text: "Sau đó thì sao?", isAI: false),
    // NormalMessage(
    //     message:
    //         "Tiếp tục với số nguyên tố tiếp theo là 3 và loại bỏ bội số của nó.",
    //     isAI: true),
    // NormalMessage(
    //     message: "Thật thú vị! Vậy thuật toán này có độ phức tạp ra sao?",
    //     isAI: false),
    // NormalMessage(
    //     message: "Độ phức tạp của nó là O(n log log n), rất nhanh.",
    //     isAI: true),
  ],
  [
    NormalMessage(
        text: "Ngoài số nguyên tố, mình muốn tìm hiểu về dãy Fibonacci.",
        isAI: false),
    NormalMessage(
        text:
            "Dãy Fibonacci là một chuỗi số mà mỗi số là tổng của hai số trước đó.",
        isAI: true),
    // NormalMessage(message: "Làm sao để tính số Fibonacci thứ n?", isAI: false),
    // NormalMessage(
    //     message: "Có thể tính bằng đệ quy hoặc quy hoạch động để tối ưu.",
    //     isAI: true),
    // NormalMessage(message: "Quy hoạch động hoạt động như thế nào?", isAI: false),
  ],
];



///Test2

// Conversation conversation = Conversation(
//     conversationId: "2",
//     dateConversation: DateTime.now(),
//     hasMore: true,
//     nameConversation: "Học toán cùng AI From API",
//     messages: [
//       MessageChat(
//         text: "11",
//         isAI: true,
//       ),
//       MessageChat(
//         message: "12",
//         isAI: false,
//       ),
//       MessageChat(
//         message: "13",
//         isAI: true,
//       ),
//       MessageChat(
//         message: "14",
//         isAI: false,
//       ),
//       MessageChat(
//         message: "15",
//         isAI: true,
//       ),
//     ],
//   );

//   final List<List<MessageChat>> additionalMessages = [
//     [
//       MessageChat(message: "6", isAI: false),
//       MessageChat(message: "7", isAI: true),
//       MessageChat(message: "8", isAI: false),
//       MessageChat(message: "9", isAI: true),
//       MessageChat(message: "10", isAI: false),
//     ],
//     [
//       MessageChat(message: "1", isAI: false),
//       MessageChat(message: "2", isAI: true),
//       MessageChat(message: "3", isAI: false),
//       MessageChat(message: "4", isAI: true),
//       MessageChat(message: "5", isAI: false),
//     ],
//     [
//       MessageChat(message: "-4", isAI: false),
//       MessageChat(message: "-3", isAI: true),
//       MessageChat(message: "-2", isAI: false),
//       MessageChat(message: "-1", isAI: true),
//       MessageChat(message: "0", isAI: false),
//     ],
//   ];
