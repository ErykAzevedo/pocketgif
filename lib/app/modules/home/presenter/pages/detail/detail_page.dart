import 'package:asuka/asuka.dart' as asuka;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:pocketmeme/app/modules/search/domain/entities/result_search.dart';

import 'detail_controller.dart';

class DetailPage extends StatefulWidget {
  final ResultSearch item;
  const DetailPage({Key key, this.item}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends ModularState<DetailPage, DetailController> {
  TextEditingController _controllerText;

  @override
  void initState() {
    super.initState();
    controller.setLikeGif(widget.item.id, widget.item.title, widget.item.imageUrl);
    controller.setTitle(widget.item.title);
    _controllerText = TextEditingController(text: widget.item.title);
  }

  @override
  Widget build(BuildContext context) {
    //double c_width = MediaQuery.of(context).size.width * 0.8;

    Widget _dialog(String title) {
      return AlertDialog(
          title: const Text('Altere o título do gif'),
          content: TextFormField(
            controller: _controllerText,
            autofocus: true,
            decoration: InputDecoration(labelText: 'Título'),
          ),
          actions: [
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            ),
            FlatButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context, rootNavigator: true).pop(_controllerText.text),
            ),
          ]);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('GIF selecionado'),
        actions: [
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Modular.link..pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Observer(builder: (_) {
        return FloatingActionButton(
          child: controller.isButtonDisabled
              ? CircularProgressIndicator(
                  backgroundColor: Colors.black54,
                )
              : Icon(Icons.save),
          onPressed: controller.isButtonDisabled
              ? null
              : () async {
                  controller.setIsButtonDisabled();
                  var msg =
                      await controller.saveLikeGif(widget.item.id, controller.title, widget.item.imageUrl);
                  controller.setIsButtonDisabled();
                  asuka.showSnackBar(SnackBar(
                    content: Text(msg),
                  ));
                },
        );
      }),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  constraints: BoxConstraints(minHeight: 100, maxHeight: 300),
                  child: Card(
                    elevation: 3,
                    child: CachedNetworkImage(
                      imageUrl: widget.item.imageUrl,
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
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text("Título",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Observer(builder: (_) {
                    return Flexible(
                      child: Container(
                        padding: EdgeInsets.only(right: 13.0),
                        child: Text(
                          controller.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () async {
                      var title = await asuka.showDialog(builder: (context) => _dialog(widget.item.title));
                      if (title != null) {
                        controller.setTitle(title);
                        //widget.item.title =
                      }
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
