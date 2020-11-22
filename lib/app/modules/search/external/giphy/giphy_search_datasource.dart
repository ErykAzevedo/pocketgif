import 'package:dio/dio.dart';
import 'package:pocketmeme/app/modules/search/domain/entities/result_search.dart';

import '../../domain/errors/errors.dart';
import '../../infra/datasources/search_datasource.dart';

class GiphySearchDatasource implements SearchDatasource {
  final Dio dio;

  GiphySearchDatasource(this.dio);

  @override
  Future<List<ResultSearch>> getSearch(String textSearch, int offset) async {
    final domain = "https://api.giphy.com/v1/gifs/search";
    final apiKey = "uB9NP1j7Th6F7Tu06HEwCf0Y9YV4N7YE";
    final text = textSearch.trim().replaceAll(' ', '');
    final limit = '10';
    final rating = 'g';
    final lang = 'pt';

    final apiUrl = '$domain?api_key=$apiKey&q=$text&limit=$limit&offset=$offset&rating=$rating&lang=$lang';
    var result = await this.dio.get(apiUrl);
    switch (result.statusCode) {
      case 200:
        var totalItems = result.data['pagination']['total_count'];

        if (totalItems == 0) {
          return throw SearchNotMatch();
        }

        var jsonList = result.data['data'] as List;
        var list = jsonList
            .map((item) => ResultSearch(
                  id: item['id'],
                  giphyUrl: item['url'],
                  sampledImageUrl: item['images']['fixed_width_downsampled']['url'],
                  imageUrl: item['images']['downsized']['url'],
                  imageHeight: item['images']['downsized']['height'],
                  imageWidth: item['images']['downsized']['width'],
                  title: item['title'],
                ))
            .toList();
        return list;
        break;
      case 400:
        throw BadRequest();
      case 403:
        throw Forbidden();
      case 404:
        throw NotFound();
      case 429:
        throw TooManyRequests();
      default:
        throw DatasourceError();
    }
  }
}
