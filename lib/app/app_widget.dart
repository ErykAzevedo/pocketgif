import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:asuka/asuka.dart' as asuka;

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: asuka.builder,
      navigatorKey: Modular.navigatorKey,
      title: 'Pocket gif',
      theme: ThemeData.dark(),
      initialRoute: '/home',
      onGenerateRoute: Modular.generateRoute,
    );
  }
}
