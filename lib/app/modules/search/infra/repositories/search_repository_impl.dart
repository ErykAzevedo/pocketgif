import 'package:dartz/dartz.dart';

import '../../domain/entities/result_search.dart';
import '../../domain/errors/errors.dart';
import '../../domain/repositories/search_repository.dart';
import '../../infra/datasources/search_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDatasource datasource;

  SearchRepositoryImpl(this.datasource);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> search(String searchText, int offset) async {
    try {
      final result = await datasource.getSearch(searchText, offset);
      return Right(result);
    } on SearchNotMatch catch (e) {
      print('Error API return SearchNotMatch: $e');
      return Left(SearchNotMatch());
    } on NotFound catch (e) {
      print('Error API return NotFound: $e');
      return Left(DatasourceError());
    } on BadRequest catch (e) {
      print('Error API return BadRequest: $e');
      return Left(DatasourceError());
    } on Forbidden catch (e) {
      print('Error API return Forbidden: $e');
      return Left(DatasourceError());
    } on TooManyRequests catch (e) {
      print('Error API return Too Many Requests: $e');
      return Left(DatasourceError());
    } catch (e) {
      return Left(DatasourceError());
    }
  }
}
