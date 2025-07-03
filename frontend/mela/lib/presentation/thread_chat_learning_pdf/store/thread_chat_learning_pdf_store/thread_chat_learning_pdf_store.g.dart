// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread_chat_learning_pdf_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ThreadChatLearningPdfStore on _ThreadChatLearningPdfStore, Store {
  Computed<String>? _$conversationNameComputed;

  @override
  String get conversationName => (_$conversationNameComputed ??=
          Computed<String>(() => super.conversationName,
              name: '_ThreadChatLearningPdfStore.conversationName'))
      .value;

  late final _$tokenChatAtom =
      Atom(name: '_ThreadChatLearningPdfStore.tokenChat', context: context);

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
      name: '_ThreadChatLearningPdfStore.currentConversation',
      context: context);

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

  late final _$currentPdfAtom =
      Atom(name: '_ThreadChatLearningPdfStore.currentPdf', context: context);

  @override
  DividedLecture get currentPdf {
    _$currentPdfAtom.reportRead();
    return super.currentPdf;
  }

  @override
  set currentPdf(DividedLecture value) {
    _$currentPdfAtom.reportWrite(value, super.currentPdf, () {
      super.currentPdf = value;
    });
  }

  late final _$startPageAtom =
      Atom(name: '_ThreadChatLearningPdfStore.startPage', context: context);

  @override
  int get startPage {
    _$startPageAtom.reportRead();
    return super.startPage;
  }

  @override
  set startPage(int value) {
    _$startPageAtom.reportWrite(value, super.startPage, () {
      super.startPage = value;
    });
  }

  late final _$endPageAtom =
      Atom(name: '_ThreadChatLearningPdfStore.endPage', context: context);

  @override
  int get endPage {
    _$endPageAtom.reportRead();
    return super.endPage;
  }

  @override
  set endPage(int value) {
    _$endPageAtom.reportWrite(value, super.endPage, () {
      super.endPage = value;
    });
  }

  late final _$currentPageAtom =
      Atom(name: '_ThreadChatLearningPdfStore.currentPage', context: context);

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_ThreadChatLearningPdfStore.isLoading', context: context);

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
      name: '_ThreadChatLearningPdfStore.isLoadingGetConversation',
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
      name: '_ThreadChatLearningPdfStore.isLoadingGetOlderMessages',
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

  late final _$sendChatMessageAsyncAction = AsyncAction(
      '_ThreadChatLearningPdfStore.sendChatMessage',
      context: context);

  @override
  Future<void> sendChatMessage(String message, List<File> images) {
    return _$sendChatMessageAsyncAction
        .run(() => super.sendChatMessage(message, images));
  }

  late final _$getTokenChatAsyncAction =
      AsyncAction('_ThreadChatLearningPdfStore.getTokenChat', context: context);

  @override
  Future<void> getTokenChat() {
    return _$getTokenChatAsyncAction.run(() => super.getTokenChat());
  }

  late final _$_ThreadChatLearningPdfStoreActionController =
      ActionController(name: '_ThreadChatLearningPdfStore', context: context);

  @override
  void setIsLoading(bool value) {
    final _$actionInfo = _$_ThreadChatLearningPdfStoreActionController
        .startAction(name: '_ThreadChatLearningPdfStore.setIsLoading');
    try {
      return super.setIsLoading(value);
    } finally {
      _$_ThreadChatLearningPdfStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsLoadingConversation(bool value) {
    final _$actionInfo =
        _$_ThreadChatLearningPdfStoreActionController.startAction(
            name: '_ThreadChatLearningPdfStore.setIsLoadingConversation');
    try {
      return super.setIsLoadingConversation(value);
    } finally {
      _$_ThreadChatLearningPdfStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPDF(
      DividedLecture question, int startPage, int endPage, int currentPage) {
    final _$actionInfo = _$_ThreadChatLearningPdfStoreActionController
        .startAction(name: '_ThreadChatLearningPdfStore.setPDF');
    try {
      return super.setPDF(question, startPage, endPage, currentPage);
    } finally {
      _$_ThreadChatLearningPdfStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearConversation() {
    final _$actionInfo = _$_ThreadChatLearningPdfStoreActionController
        .startAction(name: '_ThreadChatLearningPdfStore.clearConversation');
    try {
      return super.clearConversation();
    } finally {
      _$_ThreadChatLearningPdfStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tokenChat: ${tokenChat},
currentConversation: ${currentConversation},
currentPdf: ${currentPdf},
startPage: ${startPage},
endPage: ${endPage},
currentPage: ${currentPage},
isLoading: ${isLoading},
isLoadingGetConversation: ${isLoadingGetConversation},
isLoadingGetOlderMessages: ${isLoadingGetOlderMessages},
conversationName: ${conversationName}
    ''';
  }
}
