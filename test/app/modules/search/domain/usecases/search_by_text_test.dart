import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart' as m;
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pocketmeme/app/app_module.dart';

import 'package:pocketmeme/app/modules/search/domain/entities/result_search.dart';
import 'package:pocketmeme/app/modules/search/domain/errors/errors.dart';
import 'package:pocketmeme/app/modules/search/domain/repositories/search_repository.dart';
import 'package:pocketmeme/app/modules/search/domain/usecases/search_by_text.dart';
import 'package:pocketmeme/app/modules/search/search_module.dart';

class SearchRepositoryMock extends Mock implements SearchRepository {}

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  final repository = SearchRepositoryMock();

  initModule(AppModule(), changeBinds: [
    m.Bind<Dio>((i) => dio),
  ]);

  initModule(SearchModule(), changeBinds: [m.Bind<SearchRepository>((i) => repository)]);

  final usecase = m.Modular.get<SearchByTextImpl>();

  group('Search by Text', () {
    test('Deve retornar erro ao passar null', () async {
      when(repository.search(any, 0)).thenAnswer((_) async => Right(<ResultSearch>[]));
      var result = await usecase(null, null);
      expect(result.fold((l) => l, (r) => r), isA<InvalidTextError>());
    });

    test('Deve retornar erro ao passar vazio', () async {
      when(repository.search(any, 0)).thenAnswer((_) async => Right(<ResultSearch>[]));

      var result = await usecase('', 0);
      expect(result.fold((l) => l, (r) => r), isA<InvalidTextError>());
    });

    test('Deve retornar erro se paginação for menor que zero', () async {
      when(repository.search(any, any)).thenAnswer((_) async => Right(<ResultSearch>[]));

      var result = await usecase('', -1);
      expect(result.fold((l) => l, (r) => r), isA<InvalidTextError>());
    });

    test('Deve retornar o resultado para uma string', () async {
      when(repository.search(any, 0)).thenAnswer((_) async => Right(<ResultSearch>[ResultSearch()]));

      var result = await usecase('brazil', 0);
      expect(result | null, isA<List<ResultSearch>>());
    });
  });
}
