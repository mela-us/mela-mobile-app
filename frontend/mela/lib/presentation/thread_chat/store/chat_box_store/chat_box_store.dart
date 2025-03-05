import 'package:mela/domain/entity/message_chat/conversation.dart';
import 'package:mobx/mobx.dart';

part 'chat_box_store.g.dart';

class ChatBoxStore = _ChatBoxStore with _$ChatBoxStore;

abstract class _ChatBoxStore with Store {
  _ChatBoxStore() {}

  @observable
  bool showSendIcon = false;

  @observable
  bool isLoading = false;

  @action
  void setShowSendIcon(bool value) {
    showSendIcon = value;
  }

  @action
  void setIsLoading(bool value) {
    isLoading = value;
  }
}
  // constructor:--------------------------------