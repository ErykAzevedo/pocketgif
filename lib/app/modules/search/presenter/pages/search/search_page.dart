import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loading_gifs/loading_gifs.dart';

import '../../../domain/entities/result_search.dart';
import '../../../domain/errors/errors.dart';
import '../../../presenter/states/search_state.dart';
import 'search_controller.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key key,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends ModularState<SearchPage, SearchController> {
  ScrollController scrollController;
  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    var list = controller.listResultSearch;
    if (list != null) list.clear();
    super.dispose();
  }

  void _scrollListener() async {
    if (scrollController.position.extentAfter == 0) {
      controller.searchPagination();
    }
  }

  Widget _buildError(FailureSearch error) {
    if (error is SearchNotMatch) {
      return Center(
        child: Text('Não encontrei nada com este termo :-('),
      );
    } else if (error is BadRequest) {
      return Center(
        child: Text('Temos um erro no Giphy'),
      );
    } else {
      return Center(
        child: Text('Erro desconhecido :-('),
      );
    }
  }

  Widget _buildList(List<ResultSearch> list) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: StaggeredGridView.countBuilder(
        controller: scrollController,
        crossAxisCount: 4,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          var item = list[index];
          return GestureDetector(
            onTap: () => Modular.to.pushNamed('/home/detail',
                arguments: item), //Modular.to.pushNamed('/home/detail', arguments: item),
            child: Card(
              elevation: 3,
              child: CachedNetworkImage(
                imageUrl: item.sampledImageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Image.asset(cupertinoActivityIndicatorSmall),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          );
        },
        staggeredTileBuilder: (int index) => new StaggeredTile.count(2, index.isEven ? 2 : 1),
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giphy Search"),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              autofocus: true,
              onChanged: controller.setSearchText,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Pesquise...",
              ),
            ),
          ),
          Expanded(
            child: Observer(builder: (_) {
              var state = controller.state;

              if (state is ErrorState) {
                return _buildError(state.error);
              }
              if (state is StartState) {
                return Center(
                  child: Text('Faça sua busca por um GIF...'),
                );
              } else if (state is LoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SuccessState) {
                return _buildList(state.list);
              } else {
                return Container();
              }
            }),
          ),
        ],
      ),
    );
  }
}
