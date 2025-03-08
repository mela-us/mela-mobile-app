import 'dart:io';

import 'package:mela/domain/entity/message_chat/conversation.dart';
import 'package:mela/domain/entity/message_chat/message_chat.dart';
import 'package:mela/domain/usecase/chat/send_message_chat_usecase.dart';
import 'package:mobx/mobx.dart';

part 'thread_chat_store.g.dart';

class ThreadChatStore = _ThreadChatStore with _$ThreadChatStore;

abstract class _ThreadChatStore with Store {
  SendMessageChatUsecase sendMessageChatUsecase;
  _ThreadChatStore(this.sendMessageChatUsecase);

  @observable
  Conversation? currentConversation;

  @observable
  bool isLoading = false;

  @action
  void setIsLoading(bool value) {
    isLoading = value;
  }

  @action
  void setConversation(Conversation conversation) {
    this.currentConversation = conversation;
  }

  @action
  String getConversationName() {
    return currentConversation?.nameConversation ?? "Mela";
  }

  @action
  Future<void> sendChatMessage(String message, List<File> images) async {
    currentConversation ??= Conversation(
        conversationId: "", messages: [], nameConversation: "Mela");
    currentConversation!.messages
        .add(MessageChat(message: message, isAI: false, images: images));
    currentConversation!.messages.add(MessageChat(message: null, isAI: true));
    //Copy with to trigger thread chat screen to update
    currentConversation = currentConversation!.copyWith();

    setIsLoading(true);
    MessageChat responseMessage = await sendMessageChatUsecase.call(
        params: ChatRequestParams(
            message: message,
            conversationId: currentConversation!.conversationId));
    currentConversation!.messages.last = responseMessage;
    currentConversation = currentConversation!.copyWith();
    setIsLoading(false);
  }

  @action
  void clearConversation() {
    currentConversation = null;
  }
}
  // constructor:--------------------------------