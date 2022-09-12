// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  late final _$counterAtom =
      Atom(name: 'HomeStoreBase.counter', context: context);

  @override
  int get counter {
    _$counterAtom.reportRead();
    return super.counter;
  }

  @override
  set counter(int value) {
    _$counterAtom.reportWrite(value, super.counter, () {
      super.counter = value;
    });
  }

  late final _$selectedImageAtom =
      Atom(name: 'HomeStoreBase.selectedImage', context: context);

  @override
  PlatformFile? get selectedImage {
    _$selectedImageAtom.reportRead();
    return super.selectedImage;
  }

  @override
  set selectedImage(PlatformFile? value) {
    _$selectedImageAtom.reportWrite(value, super.selectedImage, () {
      super.selectedImage = value;
    });
  }

  late final _$predictResultAtom =
      Atom(name: 'HomeStoreBase.predictResult', context: context);

  @override
  PredictResult? get predictResult {
    _$predictResultAtom.reportRead();
    return super.predictResult;
  }

  @override
  set predictResult(PredictResult? value) {
    _$predictResultAtom.reportWrite(value, super.predictResult, () {
      super.predictResult = value;
    });
  }

  late final _$salvandoAtom =
      Atom(name: 'HomeStoreBase.salvando', context: context);

  @override
  bool get salvando {
    _$salvandoAtom.reportRead();
    return super.salvando;
  }

  @override
  set salvando(bool value) {
    _$salvandoAtom.reportWrite(value, super.salvando, () {
      super.salvando = value;
    });
  }

  late final _$setSelectedImageAsyncAction =
      AsyncAction('HomeStoreBase.setSelectedImage', context: context);

  @override
  Future setSelectedImage(PlatformFile file) {
    return _$setSelectedImageAsyncAction
        .run(() => super.setSelectedImage(file));
  }

  late final _$HomeStoreBaseActionController =
      ActionController(name: 'HomeStoreBase', context: context);

  @override
  dynamic setPredictResult(PredictResult value) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.setPredictResult');
    try {
      return super.setPredictResult(value);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
counter: ${counter},
selectedImage: ${selectedImage},
predictResult: ${predictResult},
salvando: ${salvando}
    ''';
  }
}
