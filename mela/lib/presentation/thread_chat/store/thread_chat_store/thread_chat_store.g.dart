// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread_chat_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ThreadChatStore on _ThreadChatStore, Store {
  Computed<String>? _$conversationNameComputed;

  @override
  String get conversationName => (_$conversationNameComputed ??=
          Computed<String>(() => super.conversationName,
              name: '_ThreadChatStore.conversationName'))
      .value;

  late final _$currentConversationAtom =
      Atom(name: '_ThreadChatStore.currentConversation', context: context);

  @override
  Conversation get currentConversation {
    _$currentConversationAtom.reportRead();
    return super.currentConversation;
  }

  @override
  set currentConversation(Conversation value) {
    _$currentConversationAtom.reportWrite(value, super.currentConversation, () {
      super.currentConversation = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_ThreadChatStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isLoadingGetConversationAtom =
      Atom(name: '_ThreadChatStore.isLoadingGetConversation', context: context);

  @override
  bool get isLoadingGetConversation {
    _$isLoadingGetConversationAtom.reportRead();
    return super.isLoadingGetConversation;
  }

  @override
  set isLoadingGetConversation(bool value) {
    _$isLoadingGetConversationAtom
        .reportWrite(value, super.isLoadingGetConversation, () {
      super.isLoadingGetConversation = value;
    });
  }

  late final _$isLoadingGetOlderMessagesAtom = Atom(
      name: '_ThreadChatStore.isLoadingGetOlderMessages', context: context);

  @override
  bool get isLoadingGetOlderMessages {
    _$isLoadingGetOlderMessagesAtom.reportRead();
    return super.isLoadingGetOlderMessages;
  }

  @override
  set isLoadingGetOlderMessages(bool value) {
    _$isLoadingGetOlderMessagesAtom
        .reportWrite(value, super.isLoadingGetOlderMessages, () {
      super.isLoadingGetOlderMessages = value;
    });
  }

  late final _$tokenChatAtom =
      Atom(name: '_ThreadChatStore.tokenChat', context: context);

  @override
  int get tokenChat {
    _$tokenChatAtom.reportRead();
    return super.tokenChat;
  }

  @override
  set tokenChat(int value) {
    _$tokenChatAtom.reportWrite(value, super.tokenChat, () {
      super.tokenChat = value;
    });
  }

  late final _$sendChatMessageAsyncAction =
      AsyncAction('_ThreadChatStore.sendChatMessage', context: context);

  @override
  Future<void> sendChatMessage(String message, List<File> images) {
    return _$sendChatMessageAsyncAction
        .run(() => super.sendChatMessage(message, images));
  }

  late final _$sendMessageSubmitReviewAsyncAction =
      AsyncAction('_ThreadChatStore.sendMessageSubmitReview', context: context);

  @override
  Future<void> sendMessageSubmitReview(String message, List<File> imagesParam) {
    return _$sendMessageSubmitReviewAsyncAction
        .run(() => super.sendMessageSubmitReview(message, imagesParam));
  }

  late final _$sendMessageGetSolutionAsyncAction =
      AsyncAction('_ThreadChatStore.sendMessageGetSolution', context: context);

  @override
  Future<void> sendMessageGetSolution(String message) {
    return _$sendMessageGetSolutionAsyncAction
        .run(() => super.sendMessageGetSolution(message));
  }

  late final _$getConversationAsyncAction =
      AsyncAction('_ThreadChatStore.getConversation', context: context);

  @override
  Future<void> getConversation() {
    return _$getConversationAsyncAction.run(() => super.getConversation());
  }

  late final _$getTokenChatAsyncAction =
      AsyncAction('_ThreadChatStore.getTokenChat', context: context);

  @override
  Future<void> getTokenChat() {
    return _$getTokenChatAsyncAction.run(() => super.getTokenChat());
  }

  late final _$getOlderMessagesAsyncAction =
      AsyncAction('_ThreadChatStore.getOlderMessages', context: context);

  @override
  Future<void> getOlderMessages() {
    return _$getOlderMessagesAsyncAction.run(() => super.getOlderMessages());
  }

  late final _$_ThreadChatStoreActionController =
      ActionController(name: '_ThreadChatStore', context: context);

  @override
  void setIsLoading(bool value) {
    final _$actionInfo = _$_ThreadChatStoreActionController.startAction(
        name: '_ThreadChatStore.setIsLoading');
    try {
      return super.setIsLoading(value);
    } finally {
      _$_ThreadChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsLoadingConversation(bool value) {
    final _$actionInfo = _$_ThreadChatStoreActionController.startAction(
        name: '_ThreadChatStore.setIsLoadingConversation');
    try {
      return super.setIsLoadingConversation(value);
    } finally {
      _$_ThreadChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsLoadingGetOlderMessages(bool value) {
    final _$actionInfo = _$_ThreadChatStoreActionController.startAction(
        name: '_ThreadChatStore.setIsLoadingGetOlderMessages');
    try {
      return super.setIsLoadingGetOlderMessages(value);
    } finally {
      _$_ThreadChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConversation(Conversation conversation) {
    final _$actionInfo = _$_ThreadChatStoreActionController.startAction(
        name: '_ThreadChatStore.setConversation');
    try {
      return super.setConversation(conversation);
    } finally {
      _$_ThreadChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearConversation() {
    final _$actionInfo = _$_ThreadChatStoreActionController.startAction(
        name: '_ThreadChatStore.clearConversation');
    try {
      return super.clearConversation();
    } finally {
      _$_ThreadChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentConversation: ${currentConversation},
isLoading: ${isLoading},
isLoadingGetConversation: ${isLoadingGetConversation},
isLoadingGetOlderMessages: ${isLoadingGetOlderMessages},
tokenChat: ${tokenChat},
conversationName: ${conversationName}
    ''';
  }
}
