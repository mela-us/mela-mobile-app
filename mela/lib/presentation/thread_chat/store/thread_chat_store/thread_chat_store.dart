import 'dart:io';

import 'package:mela/constants/enum.dart';
import 'package:mela/domain/entity/image_origin/image_origin.dart';
import 'package:mela/domain/entity/message_chat/conversation.dart';
import 'package:mela/domain/entity/message_chat/normal_message.dart';
import 'package:mela/domain/usecase/chat/create_new_conversation_usecase.dart';
import 'package:mela/domain/usecase/chat/get_conversation_usecase.dart';
import 'package:mela/domain/usecase/chat/get_token_chat_usecase.dart';
import 'package:mela/domain/usecase/chat/send_message_chat_usecase.dart';
import 'package:mela/domain/usecase/chat/send_message_get_solution_usecase.dart';
import 'package:mobx/mobx.dart';

import '../../../../domain/usecase/chat/send_message_review_submission_usecase.dart';

part 'thread_chat_store.g.dart';

class ThreadChatStore = _ThreadChatStore with _$ThreadChatStore;

abstract class _ThreadChatStore with Store {
  SendMessageChatUsecase sendMessageChatUsecase;
  SendMessageReviewSubmissionUsecase sendMessageReviewSubmissionUsecase;
  SendMessageGetSolutionUsecase sendMessageGetSolutionUsecase;
  GetConversationUsecase getConversationUsecase;
  CreateNewConversationUsecase createNewConversationUsecase;
  GetTokenChatUsecase getTokenChatUsecase;
  _ThreadChatStore(
      this.sendMessageChatUsecase,
      this.getConversationUsecase,
      this.createNewConversationUsecase,
      this.sendMessageReviewSubmissionUsecase,
      this.sendMessageGetSolutionUsecase,
      this.getTokenChatUsecase);

  int limit = 15;

  @observable
  Conversation currentConversation = Conversation(
      conversationId: "",
      messages: [],
      hasMore: false,
      levelConversation: LevelConversation.UNIDENTIFIED,
      dateConversation: DateTime.now(),
      nameConversation: "Đoạn Chat Mới");

  // bool isGoToFromReview = false;
  // void setIsGoToFromReview(bool value) {
  //   isGoToFromReview = value;
  // }

  @observable
  bool isLoading = false;

  @observable
  bool isLoadingGetConversation = false;

  @observable
  bool isLoadingGetOlderMessages = false;

  @observable
  int tokenChat = 0;

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
  void setIsLoadingGetOlderMessages(bool value) {
    isLoadingGetOlderMessages = value;
  }

  @action
  void setConversation(Conversation conversation) {
    this.currentConversation = conversation.copyWith();
  }

  String getConversationName() {
    return currentConversation.nameConversation.isEmpty
        ? "Đoạn Chat Mới"
        : currentConversation.nameConversation;
  }

  @action
  Future<void> sendChatMessage(String message, List<File> images) async {
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
      if (currentConversation.conversationId.isEmpty) {
        await createNewConversation(message, images);
      } else {
        await sendMessageNormal(message, images);
      }
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

  Future<void> createNewConversation(String message, List<File> images) async {
    Conversation newConversation = await createNewConversationUsecase.call(
        params: CreateNewConversationParams(
            text: message, imageFile: images.isNotEmpty ? images[0] : null));
    currentConversation.messages.last = newConversation.messages.last;
    currentConversation.nameConversation = newConversation.nameConversation;
    currentConversation.conversationId = newConversation.conversationId;
    currentConversation.levelConversation = newConversation.levelConversation;
    currentConversation = currentConversation.copyWith();
  }

  Future<void> sendMessageNormal(String message, List<File> images) async {
    Conversation responseMessage = await sendMessageChatUsecase.call(
        params: ChatRequestParams(
            message: message,
            images: images,
            conversationId: currentConversation.conversationId));
    currentConversation.messages.last = responseMessage.messages.last;
    currentConversation.nameConversation = responseMessage.nameConversation;
    currentConversation.levelConversation = responseMessage.levelConversation;
    currentConversation = currentConversation.copyWith();
  }

  @action
  Future<void> sendMessageSubmitReview(
      String message, List<File> imagesParam) async {
    try {
      List<ImageOrigin> imageSources = [];
      for (var item in imagesParam) {
        imageSources.add(ImageOrigin(image: item, isImageUrl: false));
      }
      currentConversation.messages.add(NormalMessage(
          text: message, isAI: false, imageSourceList: imageSources));
      currentConversation.messages.add(NormalMessage(text: null, isAI: true));
      //Copy with to trigger thread chat screen to update
      currentConversation = currentConversation.copyWith();

      setIsLoading(true);
      Conversation responseMessage =
          await sendMessageReviewSubmissionUsecase.call(
              params: ChatRequestParams(
                  message: message,
                  images: imagesParam,
                  conversationId: currentConversation.conversationId));

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
  Future<void> sendMessageGetSolution(String message) async {
    try {
      currentConversation.messages
          .add(NormalMessage(text: message, isAI: false));
      currentConversation.messages.add(NormalMessage(text: null, isAI: true));
      //Copy with to trigger thread chat screen to update
      currentConversation = currentConversation.copyWith();

      setIsLoading(true);
      Conversation responseMessage = await sendMessageGetSolutionUsecase.call(
          params: ChatRequestParams(
              message: message,
              conversationId: currentConversation.conversationId));

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
    limit = 15;
    currentConversation = Conversation(
        conversationId: "",
        messages: [],
        hasMore: false,
        levelConversation: LevelConversation.UNIDENTIFIED,
        dateConversation: DateTime.now(),
        nameConversation: "");
  }

  @action
  Future<void> getConversation() async {
    //for new chat
    if (currentConversation.conversationId.isEmpty) {
      return;
    }

    setIsLoadingConversation(true);
    Conversation conversation = await getConversationUsecase.call(
        params: GetConversationRequestParams(
            conversationId: currentConversation.conversationId, limit: limit));
    // print("Get conversation: ${conversation.nameConversation}");
    setConversation(Conversation(
        conversationId: currentConversation.conversationId,
        messages: conversation.messages,
        hasMore: conversation.hasMore,
        dateConversation: currentConversation.dateConversation,
        nameConversation: currentConversation.nameConversation,
        levelConversation: currentConversation.levelConversation));
    setIsLoadingConversation(false);
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

  @action
  Future<void> getOlderMessages() async {
    setIsLoadingGetOlderMessages(true);
    Conversation conversation = await getConversationUsecase.call(
        params: GetConversationRequestParams(
            conversationId: currentConversation.conversationId,
            limit: limit,
            beforeMessageId: currentConversation.messages.first.messageId));
    // print("Get conversation: ${conversation.nameConversation}");
    setConversation(Conversation(
        conversationId: currentConversation.conversationId,
        messages: [...conversation.messages, ...currentConversation.messages],
        hasMore: conversation.hasMore,
        dateConversation: currentConversation.dateConversation,
        nameConversation: currentConversation.nameConversation,
        levelConversation: currentConversation.levelConversation));
    setIsLoadingGetOlderMessages(false);
  }

  void resetLimit() {
    limit = 15;
  }
}
  // constructor:--------------------------------