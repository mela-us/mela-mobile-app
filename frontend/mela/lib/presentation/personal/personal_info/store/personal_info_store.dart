// lib/personal_info_store.dart
import 'package:mobx/mobx.dart';

part 'personal_info_store.g.dart';

class PersonalInfoStore = _PersonalInfoStore with _$PersonalInfoStore;

abstract class _PersonalInfoStore with Store {
  @observable
  String name;

  @observable
  String email;

  @observable
  String dob;

  @observable
  String password;

  _PersonalInfoStore({
    required this.name,
    required this.email,
    required this.dob,
    required this.password,
  });

  @action
  void updateName(String newName) {
    name = newName;
  }

  @action
  void updateEmail(String newEmail) {
    email = newEmail;
  }

  @action
  void updateDob(String newDob) {
    dob = newDob;
  }

  @action
  void updatePassword(String newPassword) {
    password = newPassword;
  }
}