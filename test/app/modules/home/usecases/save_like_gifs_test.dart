import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pocketmeme/app/modules/home/domain/errors/errors.dart';
import 'package:pocketmeme/app/modules/home/domain/repositories/back_repository.dart';
import 'package:pocketmeme/app/modules/home/domain/usecases/save_like_gifs.dart';

class BackRepositoryMock extends Mock implements BackRepository {}

main() {
  final repository = BackRepositoryMock();
  final usecase = SalveLikeGifImpl(repository);

  test('Retornar erro caso passe NULL', () async {
    var result = await usecase(null, null, null);
    expect(result.fold(id, id), isA<InvalidTextError>());
  });

  test('Retornar erro caso passe vazio', () async {
    var result = await usecase('', '', '');
    expect(result.fold(id, id), isA<InvalidTextError>());
  });

  test('Informando parametros corretos retorna string', () async {
    when(repository.saveLikeGif(any, any, any)).thenAnswer((_) async => Right('ok'));
    var result = await usecase('a', 'b', 'c');
    expect(result.fold(id, id), isA<String>());
  });

  test('Informando parametros incorretos retorna error', () async {
    when(repository.saveLikeGif(any, any, any)).thenAnswer((_) async => Left(DatasourceError()));
    var result = await usecase('a', 'b', 'c');
    expect(result.fold(id, id), isA<FailureHome>());
  });
}
