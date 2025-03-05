// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thread_chat_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ThreadChatStore on _ThreadChatStore, Store {
  late final _$currentConversationAtom =
      Atom(name: '_ThreadChatStore.currentConversation', context: context);

  @override
  Conversation? get currentConversation {
    _$currentConversationAtom.reportRead();
    return super.currentConversation;
  }

  @override
  set currentConversation(Conversation? value) {
    _$currentConversationAtom.reportWrite(value, super.currentConversation, () {
      super.currentConversation = value;
    });
  }

  late final _$_ThreadChatStoreActionController =
      ActionController(name: '_ThreadChatStore', context: context);

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
  String getConversationName() {
    final _$actionInfo = _$_ThreadChatStoreActionController.startAction(
        name: '_ThreadChatStore.getConversationName');
    try {
      return super.getConversationName();
    } finally {
      _$_ThreadChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void sendChatMessage(String message) {
    final _$actionInfo = _$_ThreadChatStoreActionController.startAction(
        name: '_ThreadChatStore.sendChatMessage');
    try {
      return super.sendChatMessage(message);
    } finally {
      _$_ThreadChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentConversation: ${currentConversation}
    ''';
  }
}
