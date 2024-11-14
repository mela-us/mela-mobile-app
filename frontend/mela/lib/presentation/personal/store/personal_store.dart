import 'package:mobx/mobx.dart';

part 'personal_store.g.dart';

class PersonalStore = _PersonalStore with _$PersonalStore;

abstract class _PersonalStore with Store {
  @observable
  String userName = "Anh Long";

  @action
  void updateUserName(String name) {
    userName = name;
  }

  @action
  void logout() {
    userName = "";
  }
}