import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pocketmeme/app/modules/search/domain/entities/result_search.dart';
import 'package:pocketmeme/app/modules/search/domain/errors/errors.dart';
import 'package:pocketmeme/app/modules/search/external/giphy/giphy_search_datasource.dart';
import 'package:pocketmeme/app/modules/search/util/giphy_response.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  final datasource = GiphySearchDatasource(dio);

  test('Retorno correto caso status code 200', () async {
    when(dio.get(any)).thenAnswer((_) async => Response(data: jsonDecode(giphyResponse), statusCode: 200));

    final result = datasource.getSearch('Brazil', 0);
    expect(result, isA<Future<List<ResultSearch>>>());
  });

  test('Retorno BadRequest() em caso status code 400', () async {
    when(dio.get(any)).thenAnswer((_) async => Response(data: jsonDecode(giphyResponse), statusCode: 400));

    final result = datasource.getSearch('Brazil', 0);
    expect(result, throwsA(isA<BadRequest>()));
  });

  test('Retorno Forbidden() em caso status code 403', () async {
    when(dio.get(any)).thenAnswer((_) async => Response(data: jsonDecode(giphyResponse), statusCode: 403));

    final result = datasource.getSearch('Brazil', 0);
    expect(result, throwsA(isA<Forbidden>()));
  });

  test('Retorno NotFound() em caso status code 404', () async {
    when(dio.get(any)).thenAnswer((_) async => Response(data: jsonDecode(giphyResponse), statusCode: 404));

    final result = datasource.getSearch('Brazil', 0);
    expect(result, throwsA(isA<NotFound>()));
  });

  test('Retorno TooManyRequests() em caso status code 429', () async {
    when(dio.get(any)).thenAnswer((_) async => Response(data: jsonDecode(giphyResponse), statusCode: 429));

    final result = datasource.getSearch('Brazil', 0);
    expect(result, throwsA(isA<TooManyRequests>()));
  });

  test('Retorno DatasourceError() em caso status code não esperado', () async {
    when(dio.get(any)).thenAnswer((_) async => Response(data: jsonDecode(giphyResponse), statusCode: 700));

    final result = datasource.getSearch('Brazil', 0);
    expect(result, throwsA(isA<DatasourceError>()));
  });
}
