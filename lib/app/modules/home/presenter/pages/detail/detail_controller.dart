import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pocketmeme/app/modules/home/domain/entities/result_like_gif.dart';
import 'package:pocketmeme/app/modules/home/domain/usecases/save_like_gifs.dart';
import 'package:pocketmeme/app/modules/home/presenter/stores/home_store.dart';

part 'detail_controller.g.dart';

@Injectable()
class DetailController = _DetailControllerBase with _$DetailController;

abstract class _DetailControllerBase with Store {
  final SalveLikeGif saveGif;
  final HomeStore homeStore;
  _DetailControllerBase(this.saveGif, this.homeStore);

  @observable
  String title = '';

  @observable
  bool isButtonDisabled = false;

  String id;

  String url;

  @action
  void setLikeGif(String id, String title, String url) {
    title = title;
    id = id;
    url = url;
  }

  @action
  void setTitle(String value) {
    title = value;
  }

  @action
  void setIsButtonDisabled() {
    isButtonDisabled = !isButtonDisabled;
  }

  Future<String> saveLikeGif(String id, String title, String url) async {
    var gifData = ResultLikeGif(id: id, title: title, url: url);

    homeStore.addGif(gifData);
    var result = await saveGif(id, title, url);

    if (result.isRight()) {
      return 'Gif salva com sucesso';
    } else {
      return 'Ocorreu um problema ao salvar a gif';
    }
    //result.fold((l) => (l), (r) => (r));
  }
}
