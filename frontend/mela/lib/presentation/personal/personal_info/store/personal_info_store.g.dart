// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_info_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PersonalInfoStore on _PersonalInfoStore, Store {
  late final _$nameAtom =
      Atom(name: '_PersonalInfoStore.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$emailAtom =
      Atom(name: '_PersonalInfoStore.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$dobAtom = Atom(name: '_PersonalInfoStore.dob', context: context);

  @override
  String get dob {
    _$dobAtom.reportRead();
    return super.dob;
  }

  @override
  set dob(String value) {
    _$dobAtom.reportWrite(value, super.dob, () {
      super.dob = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_PersonalInfoStore.password', context: context);

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$_PersonalInfoStoreActionController =
      ActionController(name: '_PersonalInfoStore', context: context);

  @override
  void updateName(String newName) {
    final _$actionInfo = _$_PersonalInfoStoreActionController.startAction(
        name: '_PersonalInfoStore.updateName');
    try {
      return super.updateName(newName);
    } finally {
      _$_PersonalInfoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateEmail(String newEmail) {
    final _$actionInfo = _$_PersonalInfoStoreActionController.startAction(
        name: '_PersonalInfoStore.updateEmail');
    try {
      return super.updateEmail(newEmail);
    } finally {
      _$_PersonalInfoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateDob(String newDob) {
    final _$actionInfo = _$_PersonalInfoStoreActionController.startAction(
        name: '_PersonalInfoStore.updateDob');
    try {
      return super.updateDob(newDob);
    } finally {
      _$_PersonalInfoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updatePassword(String newPassword) {
    final _$actionInfo = _$_PersonalInfoStoreActionController.startAction(
        name: '_PersonalInfoStore.updatePassword');
    try {
      return super.updatePassword(newPassword);
    } finally {
      _$_PersonalInfoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
email: ${email},
dob: ${dob},
password: ${password}
    ''';
  }
}
