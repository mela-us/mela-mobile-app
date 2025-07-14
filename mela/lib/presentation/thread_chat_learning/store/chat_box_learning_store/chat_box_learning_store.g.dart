// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_box_learning_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatBoxLearningStore on _ChatBoxLearningStore, Store {
  late final _$showSendIconAtom =
      Atom(name: '_ChatBoxLearningStore.showSendIcon', context: context);

  @override
  bool get showSendIcon {
    _$showSendIconAtom.reportRead();
    return super.showSendIcon;
  }

  @override
  set showSendIcon(bool value) {
    _$showSendIconAtom.reportWrite(value, super.showSendIcon, () {
      super.showSendIcon = value;
    });
  }

  late final _$showCameraIconAtom =
      Atom(name: '_ChatBoxLearningStore.showCameraIcon', context: context);

  @override
  bool get showCameraIcon {
    _$showCameraIconAtom.reportRead();
    return super.showCameraIcon;
  }

  @override
  set showCameraIcon(bool value) {
    _$showCameraIconAtom.reportWrite(value, super.showCameraIcon, () {
      super.showCameraIcon = value;
    });
  }

  late final _$imagesAtom =
      Atom(name: '_ChatBoxLearningStore.images', context: context);

  @override
  ObservableList<File> get images {
    _$imagesAtom.reportRead();
    return super.images;
  }

  @override
  set images(ObservableList<File> value) {
    _$imagesAtom.reportWrite(value, super.images, () {
      super.images = value;
    });
  }

  late final _$contentMessageAtom =
      Atom(name: '_ChatBoxLearningStore.contentMessage', context: context);

  @override
  String get contentMessage {
    _$contentMessageAtom.reportRead();
    return super.contentMessage;
  }

  @override
  set contentMessage(String value) {
    _$contentMessageAtom.reportWrite(value, super.contentMessage, () {
      super.contentMessage = value;
    });
  }

  late final _$pickImageAsyncAction =
      AsyncAction('_ChatBoxLearningStore.pickImage', context: context);

  @override
  Future<bool> pickImage(ImageSource imageSource) {
    return _$pickImageAsyncAction.run(() => super.pickImage(imageSource));
  }

  late final _$pickMultiImageAsyncAction =
      AsyncAction('_ChatBoxLearningStore.pickMultiImage', context: context);

  @override
  Future<void> pickMultiImage() {
    return _$pickMultiImageAsyncAction.run(() => super.pickMultiImage());
  }

  late final _$_ChatBoxLearningStoreActionController =
      ActionController(name: '_ChatBoxLearningStore', context: context);

  @override
  void setShowSendIcon(bool value) {
    final _$actionInfo = _$_ChatBoxLearningStoreActionController.startAction(
        name: '_ChatBoxLearningStore.setShowSendIcon');
    try {
      return super.setShowSendIcon(value);
    } finally {
      _$_ChatBoxLearningStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setShowCameraIcon(bool value) {
    final _$actionInfo = _$_ChatBoxLearningStoreActionController.startAction(
        name: '_ChatBoxLearningStore.setShowCameraIcon');
    try {
      return super.setShowCameraIcon(value);
    } finally {
      _$_ChatBoxLearningStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeImage(File image) {
    final _$actionInfo = _$_ChatBoxLearningStoreActionController.startAction(
        name: '_ChatBoxLearningStore.removeImage');
    try {
      return super.removeImage(image);
    } finally {
      _$_ChatBoxLearningStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearImages() {
    final _$actionInfo = _$_ChatBoxLearningStoreActionController.startAction(
        name: '_ChatBoxLearningStore.clearImages');
    try {
      return super.clearImages();
    } finally {
      _$_ChatBoxLearningStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
showSendIcon: ${showSendIcon},
showCameraIcon: ${showCameraIcon},
images: ${images},
contentMessage: ${contentMessage}
    ''';
  }
}
