import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pocketmeme/app/modules/home/domain/errors/errors.dart';
import 'package:pocketmeme/app/modules/home/domain/repositories/back_repository.dart';
import 'package:pocketmeme/app/modules/home/domain/usecases/delete_like_gift.dart';

class BackRepositoryMock extends Mock implements BackRepository {}

main() {
  final repository = BackRepositoryMock();
  final usecase = DeleteLikeGifImpl(repository);

  test('Retornar erro caso passe NULL', () async {
    var result = await usecase(null);
    expect(result.fold(id, id), isA<InvalidTextError>());
  });

  test('Retornar erro caso passe vazio', () async {
    var result = await usecase('');
    expect(result.fold(id, id), isA<InvalidTextError>());
  });

  test('Informando um ID existente retorna string', () async {
    when(repository.deleteLikeGif(any)).thenAnswer((_) async => Right('ok'));
    var result = await usecase('jgjg');
    expect(result.fold(id, id), isA<String>());
  });

  test('Informando um ID não existente retorna string', () async {
    when(repository.deleteLikeGif(any)).thenAnswer((_) async => Left(DatasourceError()));
    var result = await usecase('jgjg');
    expect(result.fold(id, id), isA<FailureHome>());
  });
}
