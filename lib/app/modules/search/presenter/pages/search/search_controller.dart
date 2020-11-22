import 'package:async/async.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/entities/result_search.dart';
import '../../../domain/usecases/search_by_text.dart';
import '../../states/search_state.dart';

part 'search_controller.g.dart';

class SearchController = _SearchControllerBase with _$SearchController;

abstract class _SearchControllerBase with Store {
  final SearchByText searchByText;
  CancelableOperation cancellableOperation;
  int position;
  bool maxItems;
  List<ResultSearch> listResultSearch;

  _SearchControllerBase(this.searchByText) {
    reaction((_) => searchText, (text) async {
      position = 0;
      maxItems = false;
      stateReaction(text, cancellableOperation);
    }, delay: 1500);
  }

  Future stateReaction(String text, [CancelableOperation cancellableOperation]) async {
    if (text.isEmpty) {
      setState(StartState());
      return;
    }

    await cancellableOperation?.cancel();
    var searchState = makeSearch(text, 0);
    cancellableOperation = CancelableOperation<SearchState>.fromFuture(searchState);

    setState(LoadingState());

    setState(await cancellableOperation.valueOrCancellation(LoadingState()));
  }

  Future<SearchState> makeSearch(String text, int position) async {
    var result = await searchByText(text, position);
    return result.fold((l) => ErrorState(l), (r) {
      listResultSearch = r;
      return SuccessState(r);
    });
  }

  void searchPagination() async {
    position += 10;
    if (!maxItems) {
      var resultPageSearch = await searchByText(searchText, position);
      var newPage = resultPageSearch.fold((l) => (l), (r) => (r));

      if (newPage is List<ResultSearch>) {
        if (newPage.length == 0) {
          maxItems = true;
        } else {
          listResultSearch = listResultSearch..addAll(newPage);
          setState(SuccessState(listResultSearch));
        }
      }
    }
  }

  @observable
  int pagination = 0;

  @observable
  String searchText = "";

  @observable
  SearchState state = StartState();

  @action
  setPagination(int value) => pagination = value;

  @action
  setSearchText(String value) => searchText = value;

  @action
  setState(SearchState value) => state = value;
}
