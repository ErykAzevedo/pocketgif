import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';
import 'package:pocketmeme/app/modules/home/domain/entities/result_like_gif.dart';
import 'package:pocketmeme/app/modules/home/domain/errors/errors.dart';
import 'package:pocketmeme/app/modules/home/domain/usecases/delete_like_gift.dart';
import 'package:pocketmeme/app/modules/home/presenter/stores/home_store.dart';

import '../../../domain/usecases/get_all_like_gif.dart';
import '../../../presenter/states/home_state.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  int position;
  bool maxItems;
  List<ResultLikeGif> listResultSearch;
  final DeleteLikeGif deleteLikeGif;
  final GetAllLikeGif getAllLikeGif;
  final HomeStore homeStore;

  _HomeControllerBase(this.getAllLikeGif, this.homeStore, this.deleteLikeGif) {
    init();
  }

  void init() async {
    setState(LoadingState());
    var result = await getAllLikeGif();
    addListGif(result);
    if (homeStore.myGifs.length > 0) {
      setState(SuccessState());
    } else {
      setState(StartState());
    }
  }

  void addListGif(Either<FailureHome, List<ResultLikeGif>> result) async {
    //var result = await getAllLikeGif();
    //return result.fold((l) => ErrorState(l), (r) => SuccessState(r));
    var x = result.fold((l) => (l), (r) => (r));
    if (x is List<ResultLikeGif>) {
      x.forEach((iten) {
        homeStore.addGif(iten);
      });
    }
  }

  void delGifToLikeList(ResultLikeGif gif) {
    homeStore.delGif(gif);
    deleteLikeGif(gif.id);
  }

  @observable
  HomeState state = StartState();

  @action
  setState(HomeState value) => state = value;
}
