import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'setting/routers/application.dart';
import 'setting/routers/routers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Widget home;

  MyApp({this.home}) {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Text("home"),
    );
  }
}
