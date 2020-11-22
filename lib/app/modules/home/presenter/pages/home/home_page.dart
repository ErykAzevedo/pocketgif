import 'dart:io';
import 'dart:typed_data';

import 'package:asuka/asuka.dart' as asuka;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loading_gifs/loading_gifs.dart';

import '../../../../home/domain/entities/result_like_gif.dart';
import '../../../../home/domain/errors/errors.dart';
import '../../../../home/presenter/states/home_state.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  Widget _buildError(FailureHome error) {
    if (error is NotFoundGif) {
      return Center(
        child: Text('Opss.. Busque seus Gifs'),
      );
    } else if (error is BadRequest) {
      return Center(
        child: Text('Temos um erro na API'),
      );
    } else {
      return Center(
        child: Text('Erro desconhecido :-('),
      );
    }
  }

  showMenuDialog(ResultLikeGif item) async {
    asuka.showDialog(
      builder: (context) => AlertDialog(
        title: const Text('Qual ação deseja?'),
        content: ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Compartilhar'),
              onTap: () async {
                await _shareImageFromUrl(item);
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Excluir'),
              onTap: () {
                controller.delGifToLikeList(item);
                Navigator.of(context, rootNavigator: true).pop();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<ResultLikeGif> list) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          var item = list[index];
          return GestureDetector(
            onTap: () async => await showMenuDialog(item), //
            child: Stack(alignment: AlignmentDirectional.topEnd, children: <Widget>[
              Card(
                child: CachedNetworkImage(
                  imageUrl: item.url,
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
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                child: Icon(Icons.apps, size: 25.0, color: Colors.black38),
              ),
            ]),
          );
        },
        staggeredTileBuilder: (int index) => new StaggeredTile.count(2, index.isEven ? 2 : 1),
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1.0,
      ),
    );
  }

  Future<void> _shareImageFromUrl(ResultLikeGif item) async {
    try {
      var request = await HttpClient().getUrl(Uri.parse(item.url));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file(item.title, '${item.id}.gif', bytes, 'image/gif');
    } catch (e) {
      print('error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Meus GIFs'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.pushNamed(context, '/search');
        },
      ),
      body: Observer(
        builder: (_) {
          var state = controller.state;

          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is StartState) {
            return Center(
              child: Text('Vamos lá, procure seu primeiro gif'),
            );
          } else if (state is SuccessState) {
            return _buildList(controller.homeStore.myGifs);
          } else if (state is ErrorState) {
            return Center(child: _buildError(state.error));
          } else {
            return _buildList(controller.homeStore.myGifs);
          }
        },
      ),
    );
  }
}
