// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $HomeStore = BindInject(
  (i) => HomeStore(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStoreBase, Store {
  final _$myGifsAtom = Atom(name: '_HomeStoreBase.myGifs');

  @override
  ObservableList<ResultLikeGif> get myGifs {
    _$myGifsAtom.reportRead();
    return super.myGifs;
  }

  @override
  set myGifs(ObservableList<ResultLikeGif> value) {
    _$myGifsAtom.reportWrite(value, super.myGifs, () {
      super.myGifs = value;
    });
  }

  final _$_HomeStoreBaseActionController =
      ActionController(name: '_HomeStoreBase');

  @override
  void addGif(ResultLikeGif value) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.addGif');
    try {
      return super.addGif(value);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void delGif(ResultLikeGif value) {
    final _$actionInfo = _$_HomeStoreBaseActionController.startAction(
        name: '_HomeStoreBase.delGif');
    try {
      return super.delGif(value);
    } finally {
      _$_HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
myGifs: ${myGifs}
    ''';
  }
}
