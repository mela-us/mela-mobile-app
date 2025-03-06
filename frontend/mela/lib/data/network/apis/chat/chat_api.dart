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
    return MessageChat(message: """This is answer from AI flutter: ================================ ở sendMessageAI API
flutter: ================================ ở sendMessageAI API
flutter: ================================ ở sendMessageAI API
flutter: ================================ ở sendMessageAI API
flutter: ================================ ở sendMessageAI API
flutter: ================================ ở sendMessageAI API""", isAI: true);
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
