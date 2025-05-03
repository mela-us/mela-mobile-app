// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hint_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HintStore on _HintStore, Store {
  late final _$hintAtom = Atom(name: '_HintStore.hint', context: context);

  @override
  String? get hint {
    _$hintAtom.reportRead();
    return super.hint;
  }

  @override
  set hint(String? value) {
    _$hintAtom.reportWrite(value, super.hint, () {
      super.hint = value;
    });
  }

  late final _$termAtom = Atom(name: '_HintStore.term', context: context);

  @override
  String? get term {
    _$termAtom.reportRead();
    return super.term;
  }

  @override
  set term(String? value) {
    _$termAtom.reportWrite(value, super.term, () {
      super.term = value;
    });
  }

  late final _$pressHintAtom =
      Atom(name: '_HintStore.pressHint', context: context);

  @override
  bool get pressHint {
    _$pressHintAtom.reportRead();
    return super.pressHint;
  }

  @override
  set pressHint(bool value) {
    _$pressHintAtom.reportWrite(value, super.pressHint, () {
      super.pressHint = value;
    });
  }

  late final _$pressTermAtom =
      Atom(name: '_HintStore.pressTerm', context: context);

  @override
  bool get pressTerm {
    _$pressTermAtom.reportRead();
    return super.pressTerm;
  }

  @override
  set pressTerm(bool value) {
    _$pressTermAtom.reportWrite(value, super.pressTerm, () {
      super.pressTerm = value;
    });
  }

  late final _$questionAtom =
      Atom(name: '_HintStore.question', context: context);

  @override
  Question? get question {
    _$questionAtom.reportRead();
    return super.question;
  }

  @override
  set question(Question? value) {
    _$questionAtom.reportWrite(value, super.question, () {
      super.question = value;
    });
  }

  late final _$isHintLoadingAtom =
      Atom(name: '_HintStore.isHintLoading', context: context);

  @override
  bool get isHintLoading {
    _$isHintLoadingAtom.reportRead();
    return super.isHintLoading;
  }

  @override
  set isHintLoading(bool value) {
    _$isHintLoadingAtom.reportWrite(value, super.isHintLoading, () {
      super.isHintLoading = value;
    });
  }

  late final _$isTermLoadingAtom =
      Atom(name: '_HintStore.isTermLoading', context: context);

  @override
  bool get isTermLoading {
    _$isTermLoadingAtom.reportRead();
    return super.isTermLoading;
  }

  @override
  set isTermLoading(bool value) {
    _$isTermLoadingAtom.reportWrite(value, super.isTermLoading, () {
      super.isTermLoading = value;
    });
  }

  late final _$generateHintAsyncAction =
      AsyncAction('_HintStore.generateHint', context: context);

  @override
  Future<void> generateHint(String questionId) {
    return _$generateHintAsyncAction.run(() => super.generateHint(questionId));
  }

  late final _$generateTermAsyncAction =
      AsyncAction('_HintStore.generateTerm', context: context);

  @override
  Future<void> generateTerm(String questionId) {
    return _$generateTermAsyncAction.run(() => super.generateTerm(questionId));
  }

  late final _$_HintStoreActionController =
      ActionController(name: '_HintStore', context: context);

  @override
  void setHint(String? hint) {
    final _$actionInfo =
        _$_HintStoreActionController.startAction(name: '_HintStore.setHint');
    try {
      return super.setHint(hint);
    } finally {
      _$_HintStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTerm(String? term) {
    final _$actionInfo =
        _$_HintStoreActionController.startAction(name: '_HintStore.setTerm');
    try {
      return super.setTerm(term);
    } finally {
      _$_HintStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleHint() {
    final _$actionInfo =
        _$_HintStoreActionController.startAction(name: '_HintStore.toggleHint');
    try {
      return super.toggleHint();
    } finally {
      _$_HintStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleTerm() {
    final _$actionInfo =
        _$_HintStoreActionController.startAction(name: '_HintStore.toggleTerm');
    try {
      return super.toggleTerm();
    } finally {
      _$_HintStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo =
        _$_HintStoreActionController.startAction(name: '_HintStore.reset');
    try {
      return super.reset();
    } finally {
      _$_HintStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
hint: ${hint},
term: ${term},
pressHint: ${pressHint},
pressTerm: ${pressTerm},
question: ${question},
isHintLoading: ${isHintLoading},
isTermLoading: ${isTermLoading}
    ''';
  }
}
