// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread_chat_learning_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ThreadChatLearningStore on _ThreadChatLearningStore, Store {
  Computed<String>? _$conversationNameComputed;

  @override
  String get conversationName => (_$conversationNameComputed ??=
          Computed<String>(() => super.conversationName,
              name: '_ThreadChatLearningStore.conversationName'))
      .value;

  late final _$tokenChatAtom =
      Atom(name: '_ThreadChatLearningStore.tokenChat', context: context);

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

  late final _$currentConversationAtom = Atom(
      name: '_ThreadChatLearningStore.currentConversation', context: context);

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

  late final _$currentQuestionAtom =
      Atom(name: '_ThreadChatLearningStore.currentQuestion', context: context);

  @override
  Question get currentQuestion {
    _$currentQuestionAtom.reportRead();
    return super.currentQuestion;
  }

  @override
  set currentQuestion(Question value) {
    _$currentQuestionAtom.reportWrite(value, super.currentQuestion, () {
      super.currentQuestion = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_ThreadChatLearningStore.isLoading', context: context);

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

  late final _$isLoadingGetConversationAtom = Atom(
      name: '_ThreadChatLearningStore.isLoadingGetConversation',
      context: context);

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
      name: '_ThreadChatLearningStore.isLoadingGetOlderMessages',
      context: context);

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

  late final _$sendChatMessageAsyncAction =
      AsyncAction('_ThreadChatLearningStore.sendChatMessage', context: context);

  @override
  Future<void> sendChatMessage(String message, List<File> images,
      {String typeMessage = "CUSTOM"}) {
    return _$sendChatMessageAsyncAction.run(
        () => super.sendChatMessage(message, images, typeMessage: typeMessage));
  }

  late final _$getTokenChatAsyncAction =
      AsyncAction('_ThreadChatLearningStore.getTokenChat', context: context);

  @override
  Future<void> getTokenChat() {
    return _$getTokenChatAsyncAction.run(() => super.getTokenChat());
  }

  late final _$_ThreadChatLearningStoreActionController =
      ActionController(name: '_ThreadChatLearningStore', context: context);

  @override
  void setIsLoading(bool value) {
    final _$actionInfo = _$_ThreadChatLearningStoreActionController.startAction(
        name: '_ThreadChatLearningStore.setIsLoading');
    try {
      return super.setIsLoading(value);
    } finally {
      _$_ThreadChatLearningStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsLoadingConversation(bool value) {
    final _$actionInfo = _$_ThreadChatLearningStoreActionController.startAction(
        name: '_ThreadChatLearningStore.setIsLoadingConversation');
    try {
      return super.setIsLoadingConversation(value);
    } finally {
      _$_ThreadChatLearningStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setQuestion(Question question) {
    final _$actionInfo = _$_ThreadChatLearningStoreActionController.startAction(
        name: '_ThreadChatLearningStore.setQuestion');
    try {
      return super.setQuestion(question);
    } finally {
      _$_ThreadChatLearningStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearConversation() {
    final _$actionInfo = _$_ThreadChatLearningStoreActionController.startAction(
        name: '_ThreadChatLearningStore.clearConversation');
    try {
      return super.clearConversation();
    } finally {
      _$_ThreadChatLearningStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tokenChat: ${tokenChat},
currentConversation: ${currentConversation},
currentQuestion: ${currentQuestion},
isLoading: ${isLoading},
isLoadingGetConversation: ${isLoadingGetConversation},
isLoadingGetOlderMessages: ${isLoadingGetOlderMessages},
conversationName: ${conversationName}
    ''';
  }
}
