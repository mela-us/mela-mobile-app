import 'package:mela/domain/entity/message_chat/conversation.dart';
import 'package:mobx/mobx.dart';

part 'thread_chat_store.g.dart';

class ThreadChatStore = _ThreadChatStore with _$ThreadChatStore;

abstract class _ThreadChatStore with Store {
  _ThreadChatStore() {}

  @observable
  Conversation? currentConversation;

  @action
  void setConversation(Conversation conversation) {
    this.currentConversation = conversation;
  }

  @action
  String getConversationName() {
    return currentConversation?.nameConversation ?? "Mela";
  }
  @action
  void sendChatMessage(String message) {
      
  }
}
  // constructor:--------------------------------