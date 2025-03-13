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

  late final _$sendChatMessageAsyncAction =
      AsyncAction('_ThreadChatStore.sendChatMessage', context: context);

  @override
  Future<void> sendChatMessage(String message, List<File> images) {
    return _$sendChatMessageAsyncAction
        .run(() => super.sendChatMessage(message, images));
  }

  late final _$getConversationAsyncAction =
      AsyncAction('_ThreadChatStore.getConversation', context: context);

  @override
  Future<void> getConversation() {
    return _$getConversationAsyncAction.run(() => super.getConversation());
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
conversationName: ${conversationName}
    ''';
  }
}
