import 'package:flutter_modular/flutter_modular.dart';

import 'domain/usecases/delete_like_gift.dart';
import 'domain/usecases/get_all_like_gif.dart';
import 'domain/usecases/save_like_gifs.dart';
import 'domain/usecases/update_like_gif.dart';
import 'external/back_datasource.dart';
import 'infra/repositories/back_repository_impl.dart';
import 'presenter/pages/detail/detail_controller.dart';
import 'presenter/pages/detail/detail_page.dart';
import 'presenter/pages/home/home_controller.dart';
import 'presenter/pages/home/home_page.dart';
import 'presenter/stores/home_store.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController(i(), i(), i())),
        Bind((i) => DetailController(i(), i())),
        Bind((i) => DeleteLikeGifImpl(i())),
        Bind((i) => GetAllLikeGifImpl(i())),
        Bind((i) => SalveLikeGifImpl(i())),
        Bind((i) => UpdateLikeGifImpl(i())),
        Bind((i) => BackRepositoryImpl(i())),
        Bind((i) => FFDatasource(i())),
        Bind((i) => HomeStore()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, args) => HomePage()),
        ModularRouter('/detail', child: (_, args) => DetailPage(item: args.data)),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
