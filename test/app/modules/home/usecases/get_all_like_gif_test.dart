import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pocketmeme/app/modules/home/domain/entities/result_like_gif.dart';
import 'package:pocketmeme/app/modules/home/domain/errors/errors.dart';
import 'package:pocketmeme/app/modules/home/domain/repositories/back_repository.dart';
import 'package:pocketmeme/app/modules/home/domain/usecases/get_all_like_gif.dart';

class BackRepositoryMock extends Mock implements BackRepository {}

main() {
  final repository = BackRepositoryMock();
  final usecase = GetAllLikeGifImpl(repository);

  test('Informando um ID existente retorna string', () async {
    when(repository.getAllLikeGif()).thenAnswer((_) async => Right(<ResultLikeGif>[ResultLikeGif()]));
    var result = await usecase();
    expect(result.fold(id, id), isA<List<ResultLikeGif>>());
  });

  test('Erro ao solicitar a lista', () async {
    when(repository.getAllLikeGif()).thenAnswer((_) async => Left(DatasourceError()));
    var result = await usecase();
    expect(result.fold(id, id), isA<FailureHome>());
  });
}
