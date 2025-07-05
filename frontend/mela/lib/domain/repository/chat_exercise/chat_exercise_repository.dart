import 'package:mela/domain/entity/message_chat/conversation.dart';
import 'package:mela/domain/usecase/chat_with_exercise/send_message_chat_exercise_usecase.dart';
import 'package:mela/domain/usecase/chat_with_exercise/send_message_chat_pdf_usecase.dart';

abstract class ChatExerciseRepository {
  Future<Conversation> sendMessageExercise(
      ChatExerciseRequestParams
          params); //Response Conversation not MessageChat because title, status conversation will be updated
  Future<Conversation> sendMessagePdf(
      ChatPdfRequestParams
          params); //Response Conversation not MessageChat because title, status conversation will be updated
}
