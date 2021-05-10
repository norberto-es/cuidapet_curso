import 'package:cuidapet_curso/app/core/theme_cuidapet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Get.addKey(
          Modular.navigatorKey), //agregadopara get funconar con modular
      title: 'Cuidapet ',
      debugShowCheckedModeBanner: false,
      theme: ThemeCuidapet.theme(),
      initialRoute: '/',
      onGenerateRoute: Modular.generateRoute,
      navigatorObservers: [
        GetObserver()
      ], //agregado para o get funccionar con modular
    );
  }
}
