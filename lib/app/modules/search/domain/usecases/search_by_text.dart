import 'package:dartz/dartz.dart';

import '../entities/result_search.dart';
import '../errors/errors.dart';
import '../repositories/search_repository.dart';

abstract class SearchByText {
  Future<Either<FailureSearch, List<ResultSearch>>> call(String searchText, int offset);
}

class SearchByTextImpl implements SearchByText {
  final SearchRepository repository;
  SearchByTextImpl(this.repository);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> call(String searchText, int offset) async {
    if (searchText == null || searchText.isEmpty) {
      return Left(InvalidTextError());
    }
    if (offset.isNaN || offset.isNegative) {
      return Left(InvalidTextError());
    }
    return repository.search(searchText, offset);
  }
}
