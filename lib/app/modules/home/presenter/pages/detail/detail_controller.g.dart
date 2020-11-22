// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $DetailController = BindInject(
  (i) => DetailController(i<SalveLikeGif>(), i<HomeStore>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DetailController on _DetailControllerBase, Store {
  final _$titleAtom = Atom(name: '_DetailControllerBase.title');

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  final _$isButtonDisabledAtom =
      Atom(name: '_DetailControllerBase.isButtonDisabled');

  @override
  bool get isButtonDisabled {
    _$isButtonDisabledAtom.reportRead();
    return super.isButtonDisabled;
  }

  @override
  set isButtonDisabled(bool value) {
    _$isButtonDisabledAtom.reportWrite(value, super.isButtonDisabled, () {
      super.isButtonDisabled = value;
    });
  }

  final _$_DetailControllerBaseActionController =
      ActionController(name: '_DetailControllerBase');

  @override
  void setLikeGif(String id, String title, String url) {
    final _$actionInfo = _$_DetailControllerBaseActionController.startAction(
        name: '_DetailControllerBase.setLikeGif');
    try {
      return super.setLikeGif(id, title, url);
    } finally {
      _$_DetailControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTitle(String value) {
    final _$actionInfo = _$_DetailControllerBaseActionController.startAction(
        name: '_DetailControllerBase.setTitle');
    try {
      return super.setTitle(value);
    } finally {
      _$_DetailControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsButtonDisabled() {
    final _$actionInfo = _$_DetailControllerBaseActionController.startAction(
        name: '_DetailControllerBase.setIsButtonDisabled');
    try {
      return super.setIsButtonDisabled();
    } finally {
      _$_DetailControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
title: ${title},
isButtonDisabled: ${isButtonDisabled}
    ''';
  }
}
