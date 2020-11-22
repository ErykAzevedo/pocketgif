import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../home/domain/entities/result_like_gif.dart';

part 'home_store.g.dart';

@Injectable()
class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  @observable
  ObservableList<ResultLikeGif> myGifs = ObservableList<ResultLikeGif>();

  @action
  void addGif(ResultLikeGif value) {
    var repeated = myGifs.where((element) => element.id == value.id);
    if (repeated.length == 0) myGifs.add(value);
  }

  @action
  void delGif(ResultLikeGif value) => myGifs.remove(value);
}
