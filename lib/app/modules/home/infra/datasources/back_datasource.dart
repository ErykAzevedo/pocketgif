import 'package:pocketmeme/app/modules/home/domain/entities/result_like_gif.dart';

abstract class BackDatasource {
  Future<List<ResultLikeGif>> getAllLikeGif();
  Future<String> saveLikeGif(String id, String title, String url);
  Future<String> deleteLikeGif(String id);
  Future<String> updateLikeGif(String id, String title, String url);
}
