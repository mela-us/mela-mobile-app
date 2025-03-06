import 'package:mobx/mobx.dart';

part 'chat_box_store.g.dart';

class ChatBoxStore = _ChatBoxStore with _$ChatBoxStore;

abstract class _ChatBoxStore with Store {
  _ChatBoxStore() {}

  @observable
  bool showSendIcon = false;

  @action
  void setShowSendIcon(bool value) {
    showSendIcon = value;
  }
}
  // constructor:--------------------------------