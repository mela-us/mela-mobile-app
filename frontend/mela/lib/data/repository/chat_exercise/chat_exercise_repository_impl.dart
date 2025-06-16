import 'package:mela/data/network/apis/chat/chat_api.dart';
import 'package:mela/domain/entity/message_chat/conversation.dart';
import 'package:mela/domain/repository/chat/chat_repository.dart';
import 'package:mela/domain/repository/chat_exercise/chat_exercise_repository.dart';
import 'package:mela/domain/usecase/chat/create_new_conversation_usecase.dart';
import 'package:mela/domain/usecase/chat/get_conversation_usecase.dart';
import 'package:mela/domain/usecase/chat/send_message_chat_usecase.dart';
import 'package:mela/domain/usecase/chat_with_exercise/send_message_chat_exercise_usecase.dart';

class ChatExerciseRepositoryImpl extends ChatExerciseRepository {
  ChatApi _chatApi;
  ChatExerciseRepositoryImpl(this._chatApi);

  @override
  Future<Conversation> sendMessageExercise(ChatExerciseRequestParams params) {
    return _chatApi.sendMessageChatExercise(params);
  }
}
