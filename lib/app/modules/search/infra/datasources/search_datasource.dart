import 'package:pocketmeme/app/modules/search/domain/entities/result_search.dart';

abstract class SearchDatasource {
  Future<List<ResultSearch>> getSearch(String searchText, int offset);
}
