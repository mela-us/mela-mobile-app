import 'package:mela/data/network/apis/chat/dummy_data.dart';
import 'package:mela/data/network/constants/endpoints_const.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/domain/entity/chat/history_item.dart';
import 'package:mela/domain/entity/message_chat/conversation.dart';
import 'package:mela/domain/entity/message_chat/message_chat.dart';
import 'package:mela/domain/entity/message_chat/normal_message.dart';
import 'package:mela/domain/usecase/chat/create_new_conversation_usecase.dart';
import 'package:mela/domain/usecase/chat/get_conversation_usecase.dart';
import 'package:mela/domain/usecase/chat/send_message_chat_usecase.dart';

class ChatApi {
  DioClient _dioClient;
  ChatApi(this._dioClient);

  //=======Test
  Conversation _conversation = conversation1;

  final List<List<MessageChat>> _additionalMessages = additionalMessages1;

  int _currentIndex = 0;

  //================================================================

  Future<Conversation> sendMessageChat(ChatRequestParams params) async {
    // print("================================ ở sendMessageAI API");
    // await Future.delayed(const Duration(seconds: 4));
    // return NormalMessage(
    //     text:
    //         """This is answer from AI Mela.\nPhân tích đề bài:\nĐề bài yêu cầu điền các số còn thiếu vào dãy số:\n5, 10, 15, ..., 25, ..., 35, ..., 45, 505, 10, 15.\nHướng làm:\n• Xác định công sai hoặc quy luật giữa các số.\n• Tìm công thức tổng quát nếu có.\n• Điền các số còn thiếu dựa trên quy luật.\n• Kiểm tra lại xem dãy số có lặp lại hoặc có phần riêng biệt không.\n• Xác định ý nghĩa của số 505 và số lặp lại ở cuối dãy.""",
    //     isAI: true);
    final responseData = await _dioClient.post(
      EndpointsConst.sendMessageChat
          .replaceAll(':conversationId', params.conversationId!),
      data: params.toJson(),
    );
    return Conversation.fromJson(responseData);
  }

  Future<Conversation> sendMessageReviewSubmission(
      ChatRequestParams params) async {
    final responseData = await _dioClient.post(
      EndpointsConst.sendMessageReviewSubmission
          .replaceAll(':conversationId', params.conversationId!),
      data: params.toJson(),
    );
    return Conversation.fromJson(responseData);
  }

  Future<Conversation> sendMessageGetSolution(ChatRequestParams params) async {
    final responseData = await _dioClient.post(
      EndpointsConst.sendMessageGetSolution
          .replaceAll(':conversationId', params.conversationId!),
      data: params.toJson(),
    );
    return Conversation.fromJson(responseData);
  }

  Future<Conversation> getConversation(
      GetConversationRequestParams params) async {
    print("================================ Đang gọi getConversation API");
    await Future.delayed(const Duration(seconds: 4));
    _conversation.messages.insertAll(0, _additionalMessages[_currentIndex % 3]);
    _currentIndex++;

    return _conversation;
  }

  Future<Conversation> createNewConversation(
      CreateNewConversationParams params) async {
    final responseData = await _dioClient.post(
      EndpointsConst.createNewConversation,
      data: params.toJson(),
    );
    return Conversation.fromJson(responseData);
  }

  Future<List<HistoryItem>> getHistoryChat() async {
    final response = await _dioClient.get(EndpointsConst.getChatHistory);

    if (response.statusCode == 200) {
      print("--API GET HISTORY--");
      print(response.data);
      List<dynamic> dataList = response.data["data"];
      List<HistoryItem> temp =
          dataList.map((item) => HistoryItem.fromJson(item)).toList();
      return temp;
    }
    return [];
  }
}
