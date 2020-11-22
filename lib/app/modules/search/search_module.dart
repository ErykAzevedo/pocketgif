import 'package:flutter_modular/flutter_modular.dart';

import 'domain/usecases/search_by_text.dart';
import 'external/giphy/giphy_search_datasource.dart';
import 'infra/repositories/search_repository_impl.dart';
import 'presenter/pages/search/search_controller.dart';
import 'presenter/pages/search/search_page.dart';

class SearchModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SearchController(i())),
        Bind((i) => GiphySearchDatasource(i())),
        Bind((i) => SearchRepositoryImpl(i())),
        Bind((i) => SearchByTextImpl(i())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => SearchPage()),
      ];

  static Inject get to => Inject<SearchModule>.of();
}
