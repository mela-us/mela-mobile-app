import 'dart:convert';
import 'dart:io';

import 'package:mela/constants/enum.dart';
import 'package:mela/data/network/apis/chat/dummy_data.dart';
import 'package:mela/data/network/constants/endpoints_const.dart';
import 'package:mela/data/network/dio_client.dart';
import 'package:mela/data/securestorage/secure_storage_helper.dart';
import 'package:mela/domain/entity/chat/history_item.dart';
import 'package:mela/domain/entity/chat/history_response.dart';
import 'package:mela/domain/entity/message_chat/conversation.dart';
import 'package:mela/domain/entity/message_chat/message_chat.dart';
import 'package:mela/domain/entity/message_chat/normal_message.dart';
import 'package:mela/domain/usecase/chat/create_new_conversation_usecase.dart';
import 'package:mela/domain/usecase/chat/get_conversation_usecase.dart';
import 'package:mela/domain/usecase/chat/send_message_chat_usecase.dart';
import 'package:mela/domain/usecase/chat_with_exercise/send_message_chat_exercise_usecase.dart';
import 'package:mela/domain/usecase/chat_with_exercise/send_message_chat_pdf_usecase.dart';

class ChatApi {
  DioClient _dioClient;
  SecureStorageHelper _store;
  ChatApi(this._dioClient, this._store);

  //=======Test
  // Conversation _conversation = conversation1;

  // final List<List<MessageChat>> _additionalMessages = additionalMessages1;

  // int _currentIndex = 0;

  //================================================================

  Future<Conversation> sendMessageChat(ChatRequestParams params) async {
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
    // print("================================ Đang gọi getConversation API");
    // await Future.delayed(const Duration(seconds: 4));
    // _conversation.messages.insertAll(0, _additionalMessages[_currentIndex % 3]);
    // _currentIndex++;
    final responseData = await _dioClient.get(
      EndpointsConst.getMessageInConversation
          .replaceAll(':conversationId', params.conversationId),
      data: params.toMap(),
    );
    // print("================================ getConversation API");
    // print(responseData);

    //Chỗ này thực ra chỉ cần trả về messages là đủ, nhưng mà cái này cần cái hasMore nữa nên thôi trả về như này luôn
    return Conversation(
        conversationId: params.conversationId, //Not important
        messages: (responseData['data'] as List<dynamic>)
            .map((message) => MessageChat.fromJson(message))
            .toList(),
        hasMore: responseData['hasMore'] ?? false, //Important to map in store
        dateConversation: DateTime.now(), //Not important
        nameConversation: "", //Not important
        levelConversation: LevelConversation.UNIDENTIFIED //Not important
        );
  }

  Future<Conversation> createNewConversation(
      CreateNewConversationParams params) async {
    final responseData = await _dioClient.post(
      EndpointsConst.createNewConversation,
      data: params.toJson(),
    );
    return Conversation.fromJson(responseData);
  }

  Future<HistoryResponse> getHistoryChat(DateTime? timestamp) async {
    var data;

    if (timestamp == null) {
      data = {'order': 'desc', 'limit': '20'};
    } else {
      data = {
        'order': 'desc',
        'limit': '20',
        'updatedAtBefore': timestamp.toIso8601String()
      };
      print("Data: ${data.toString()}");
    }

    String? token = await _store.accessToken;
    if (token == null) {
      throw 401;
    }
    HttpClient client = HttpClient();
    final Uri uri =
        Uri.parse("${EndpointsConst.baseUrl}${EndpointsConst.getChatHistory}");
    HttpClientRequest request = await client.openUrl('GET', uri);
    request.headers.set('Authorization', 'Bearer $token');
    request.headers.set('Content-Type', 'application/json');

    String body = jsonEncode(data);
    request.headers.contentLength = utf8.encode(body).length;
    request.add(utf8.encode(body));
    try {
      HttpClientResponse response = await request.close();
      String responseBody = await utf8.decodeStream(response);
      print("--API GET HISTORY--");
      print("Response: $responseBody");
      var jsonResponse = await jsonDecode(responseBody);
      HistoryResponse temp = HistoryResponse.fromJson(jsonResponse);

      return temp;
    } catch (e) {
      print("Error: $e");
    } finally {
      client.close();
    }
    return HistoryResponse(
        object: '',
        firstUpdateAt: DateTime.now(),
        lastUpdateAt: DateTime.now(),
        hasMore: false,
        data: []);
  }

  Future<int> getTokenChat() async {
    final responseData = await _dioClient.get(EndpointsConst.getTokenChat);

    return responseData['token'] ?? 0;
  }

  //Chat with exercise and pdf
  Future<Conversation> sendMessageChatExercise(
      ChatExerciseRequestParams params) async {
    final responseData = await _dioClient.post(
      EndpointsConst.sendMessageChatExercise
          .replaceAll(':questionId', params.questionId!),
      data: params.toJson(),
    );
    return Conversation(
        conversationId: "",
        messages: [NormalMessage(isAI: true, text: responseData['content'])],
        hasMore: false,
        dateConversation: DateTime.now(),
        nameConversation: "", //Not important
        levelConversation: LevelConversation.UNIDENTIFIED //Not important
        );
  }

  Future<int> deleteConversation(String conversationId) async {
    final responseData = await _dioClient
        .delete(EndpointsConst.deleteConversation(conversationId));
    print("Deleting $conversationId");
    return responseData.statusCode;
  }

  Future<Conversation> sendMessageChatPdf(ChatPdfRequestParams params) async {
    final responseData = await _dioClient.post(
      EndpointsConst.sendMessageChatPdf,
      data: params.toJson(),
    );
    return Conversation(
        conversationId: "",
        messages: [NormalMessage(isAI: true, text: responseData['content'])],
        hasMore: false,
        dateConversation: DateTime.now(),
        nameConversation: "", //Not important
        levelConversation: LevelConversation.UNIDENTIFIED //Not important
        );
  }
}
