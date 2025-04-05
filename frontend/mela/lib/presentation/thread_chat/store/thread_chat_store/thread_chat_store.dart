import 'dart:io';

import 'package:mela/constants/enum.dart';
import 'package:mela/domain/entity/image_origin/image_origin.dart';
import 'package:mela/domain/entity/message_chat/conversation.dart';
import 'package:mela/domain/entity/message_chat/normal_message.dart';
import 'package:mela/domain/usecase/chat/create_new_conversation_usecase.dart';
import 'package:mela/domain/usecase/chat/get_conversation_usecase.dart';
import 'package:mela/domain/usecase/chat/send_message_chat_usecase.dart';
import 'package:mobx/mobx.dart';

part 'thread_chat_store.g.dart';

class ThreadChatStore = _ThreadChatStore with _$ThreadChatStore;

abstract class _ThreadChatStore with Store {
  SendMessageChatUsecase sendMessageChatUsecase;
  GetConversationUsecase getConversationUsecase;
  CreateNewConversationUsecase createNewConversationUsecase;
  _ThreadChatStore(this.sendMessageChatUsecase, this.getConversationUsecase,
      this.createNewConversationUsecase);

  int limit = 10;

  @observable
  Conversation currentConversation = Conversation(
      conversationId: "",
      messages: [],
      hasMore: false,
      levelConversation: LevelConversation.UNIDENTIFIED,
      dateConversation: DateTime.now(),
      nameConversation: "Instance Title");

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
  void setIsLoadingGetOlderMessages(bool value) {
    isLoadingGetOlderMessages = value;
  }

  @action
  void setConversation(Conversation conversation) {
    this.currentConversation = conversation.copyWith();
  }

  String getConversationName() {
    return currentConversation.nameConversation.isEmpty
        ? "Mela New Chat"
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
        Conversation newConversation = await createNewConversationUsecase.call(
            params: CreateNewConversationParams(
                text: message,
                imageFile: images.isNotEmpty ? images[0] : null));
        currentConversation.messages.last = newConversation.messages.last;
        currentConversation.nameConversation = newConversation.nameConversation;
        currentConversation.conversationId = newConversation.conversationId;
        currentConversation.levelConversation =
            newConversation.levelConversation;
        currentConversation = currentConversation.copyWith();
      } else {
        Conversation responseMessage = await sendMessageChatUsecase.call(
            params: ChatRequestParams(
                message: message,
                conversationId: currentConversation.conversationId));
        currentConversation.messages.last = responseMessage.messages.last;
        currentConversation.nameConversation = responseMessage.nameConversation;
        currentConversation.levelConversation =
            responseMessage.levelConversation;
        currentConversation = currentConversation.copyWith();
      }
    } catch (e) {
      print("Error: $e");
      currentConversation.messages.last =
          NormalMessage(text: e.toString(), isAI: true);
      currentConversation = currentConversation.copyWith();
    } finally {
      setIsLoading(false);
    }
  }

  @action
  void clearConversation() {
    limit = 10;
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
    setConversation(conversation);
    setIsLoadingConversation(false);
  }

  @action
  Future<void> getOlderMessages() async {
    setIsLoadingGetOlderMessages(true);
    limit += 10;
    Conversation conversation = await getConversationUsecase.call(
        params: GetConversationRequestParams(
            conversationId: currentConversation.conversationId, limit: limit));
    setConversation(conversation);
    setIsLoadingGetOlderMessages(false);
  }

  void resetLimit() {
    limit = 10;
  }
}
  // constructor:--------------------------------