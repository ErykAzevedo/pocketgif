import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pocketmeme/app/modules/search/domain/entities/result_search.dart';
import 'package:pocketmeme/app/modules/search/domain/errors/errors.dart';
import 'package:pocketmeme/app/modules/search/infra/datasources/search_datasource.dart';
import 'package:pocketmeme/app/modules/search/infra/repositories/search_repository_impl.dart';

class SearchDatasourceMock extends Mock implements SearchDatasource {}

main() {
  final datasource = SearchDatasourceMock();
  final repository = SearchRepositoryImpl(datasource);

  test('Retorna DatasourceError em caso de throw', () async {
    when(datasource.getSearch(any, any)).thenThrow(Exception());
    final result = await repository.search('searchText', 0);

    expect(result.fold((l) => l, (r) => r), isA<DatasourceError>());
  });
  test('Retorna lista de ResultSearch em positivo', () async {
    when(datasource.getSearch(any, any)).thenAnswer((_) async => <ResultSearch>[]);
    final result = await repository.search('searchText', 0);

    expect(result.fold((l) => l, (r) => r), isA<List<ResultSearch>>());
  });
}
