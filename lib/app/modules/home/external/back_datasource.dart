import 'package:dio/dio.dart';
import 'package:pocketmeme/app/modules/home/domain/errors/errors.dart';

import '../../home/domain/entities/result_like_gif.dart';
import '../../home/infra/datasources/back_datasource.dart';

class FFDatasource implements BackDatasource {
  final Dio dio;
  FFDatasource(this.dio);

  @override
  Future<String> deleteLikeGif(String id) async {
    final url = 'https://us-central1-exla-unifatea.cloudfunctions.net/finxi/api/v1/gifs/$id';

    var result = await this.dio.delete(url);

    switch (result.statusCode) {
      case 200:
        return 'ok';
        break;
      default:
        throw DatasourceError();
    }
  }

  @override
  Future<String> saveLikeGif(String id, String title, String url) async {
    const apiUrl = 'https://us-central1-exla-unifatea.cloudfunctions.net/finxi/api/v1/gifs/';

    final data = '{"id":"$id","title":"$title","url": "$url"}';
    var result = await this.dio.post(apiUrl, data: data);

    switch (result.statusCode) {
      case 201:
        return 'ok';
        break;
      default:
        throw DatasourceError();
    }
  }

  @override
  Future<String> updateLikeGif(String id, String title, String url) async {
    const apiUrl = 'https://us-central1-exla-unifatea.cloudfunctions.net/finxi/api/v1/gifs/';

    final data = '{"id":"$id","title":"$title","url": "$url"}';
    var result = await this.dio.post(apiUrl, data: data);

    switch (result.statusCode) {
      case 201:
        return 'ok';
        break;
      default:
        throw DatasourceError();
    }
  }

  @override
  Future<List<ResultLikeGif>> getAllLikeGif() async {
    const url = 'https://us-central1-exla-unifatea.cloudfunctions.net/finxi/api/v1/gifs/';

    var result = await this.dio.get(url);

    switch (result.statusCode) {
      case 200:
        var jsonList = result.data as List;
        var list = jsonList
            .map((item) => ResultLikeGif(id: item['id'], title: item['title'], url: item['url']))
            .toList();
        return list;
        break;
      case 204:
        return throw NotFoundGif();
        break;
      default:
        throw DatasourceError();
    }
  }
}
