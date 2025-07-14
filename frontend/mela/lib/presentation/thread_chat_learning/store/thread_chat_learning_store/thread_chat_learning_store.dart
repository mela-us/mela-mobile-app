import 'dart:io';

import 'package:mela/constants/enum.dart';
import 'package:mela/domain/entity/image_origin/image_origin.dart';
import 'package:mela/domain/entity/message_chat/conversation.dart';
import 'package:mela/domain/entity/message_chat/normal_message.dart';
import 'package:mela/domain/entity/question/question.dart';
import 'package:mela/domain/usecase/chat/create_new_conversation_usecase.dart';
import 'package:mela/domain/usecase/chat/get_token_chat_usecase.dart';
import 'package:mela/domain/usecase/chat_with_exercise/send_message_chat_exercise_usecase.dart';
import 'package:mobx/mobx.dart';

part 'thread_chat_learning_store.g.dart';

class ThreadChatLearningStore = _ThreadChatLearningStore
    with _$ThreadChatLearningStore;

abstract class _ThreadChatLearningStore with Store {
  SendMessageChatExerciseUsecase sendMessageChatExerciseUsecase;
  GetTokenChatUsecase getTokenChatUsecase;
  _ThreadChatLearningStore(
    this.getTokenChatUsecase,
    this.sendMessageChatExerciseUsecase,
  );
  @observable
  int tokenChat = 0;

  int limit = 5;

  @observable
  Conversation currentConversation = Conversation(
      conversationId: "",
      messages: [],
      hasMore: false,
      levelConversation: LevelConversation.UNIDENTIFIED,
      dateConversation: DateTime.now(),
      nameConversation: "Đoạn Chat Mới");
  @observable
  Question currentQuestion = Question(
      questionId: null,
      ordinalNumber: 1,
      content: "",
      questionType: "",
      options: [],
      blankAnswer: "",
      solution: "",
      guide: null,
      term: null);

  @observable
  bool isLoading = false;

  @observable
  bool isLoadingGetConversation = false;

  @observable
  bool isLoadingGetOlderMessages = false;

  @computed
  String get conversationName => getConversationName();

  @action
  void setIsLoading(bool value) {
    //Loading send
    isLoading = value;
  }

  @action
  void setIsLoadingConversation(bool value) {
    isLoadingGetConversation = value;
  }

  @action
  void setQuestion(Question question) {
    this.currentQuestion = Question(
      questionId: question.questionId,
      ordinalNumber: question.ordinalNumber,
      content: question.content,
      questionType: question.questionType,
      options: question.options,
      blankAnswer: question.blankAnswer,
      solution: question.solution,
      guide: question.guide,
      term: question.term,
    );
  }

  String getConversationName() {
    return currentConversation.nameConversation.isEmpty
        ? "Đoạn Chat Mới"
        : currentConversation.nameConversation;
  }

  @action
  Future<void> sendChatMessage(String message, List<File> images,
      {String typeMessage = "CUSTOM"}) async {
    try {
      List<ImageOrigin> imageSources = [];
      for (var item in images) {
        imageSources.add(ImageOrigin(image: item, isImageUrl: false));
      }
      currentConversation.messages.add(NormalMessage(
          text: message, isAI: false, imageSourceList: imageSources));
      currentConversation.messages.add(NormalMessage(text: null, isAI: true));
      //Copy with to trigger thread chat screen to update
      currentConversation = currentConversation.copyWith();
      setIsLoading(true);
      Conversation responseMessage = await sendMessageChatExerciseUsecase.call(
          params: ChatExerciseRequestParams(
              message: message,
              images: images,
              typeMessage: typeMessage,
              questionId: currentQuestion.questionId ?? "QuestionID null"));
      currentConversation.messages.last = responseMessage.messages.last;
      currentConversation.nameConversation = responseMessage.nameConversation;
      currentConversation.levelConversation = responseMessage.levelConversation;
      currentConversation = currentConversation.copyWith();
      await getTokenChat();
    } catch (e) {
      print("Error: $e");
      currentConversation.messages.last = NormalMessage(
          text: "Có lỗi xảy ra. Bạn thử lại sau giúp Mela nhé!", isAI: true);
      currentConversation = currentConversation.copyWith();
    } finally {
      setIsLoading(false);
    }
  }

  @action
  void clearConversation() {
    limit = 5;
    currentConversation = Conversation(
        conversationId: "",
        messages: [],
        hasMore: false,
        levelConversation: LevelConversation.UNIDENTIFIED,
        dateConversation: DateTime.now(),
        nameConversation: "");
  }

  @action
  Future<void> getTokenChat() async {
    try {
      int token = await getTokenChatUsecase.call();
      tokenChat = token;
    } catch (e) {
      print("Error when get token chat: $e");
      tokenChat = 0;
    }
  }

  void resetLimit() {
    limit = 5;
  }
}
  // constructor:--------------------------------