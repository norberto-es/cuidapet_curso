import 'package:cuidapet_curso/app/app_controller.dart';
import 'package:cuidapet_curso/app/core/database/connection_adm.dart';

import 'package:cuidapet_curso/app/modules/login/login_module.dart';
import 'package:cuidapet_curso/app/modules/main_page/main_page.dart';
import 'package:cuidapet_curso/app/repository/endereco_repository.dart';
import 'package:cuidapet_curso/app/repository/usuario_repository.dart';
import 'package:cuidapet_curso/app/services/endereco_services.dart';
import 'package:cuidapet_curso/app/services/usuario_service.dart';
import 'package:cuidapet_curso/app/shared/auth_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:cuidapet_curso/app/app_widget.dart';
import 'package:cuidapet_curso/app/modules/home/home_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ConnectionADM(), lazy: false),
        Bind((i) => AppController()),
        Bind((i) => UsuarioRepository()),
        Bind((i) => UsuarioService(i.get())),
        Bind((i) => EnderecoRepository()),
        Bind((i) => EnderecoServices(i.get())),
        Bind((i) => AuthStore()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (context, args) => MainPage()),
        ModularRouter('/home', module: HomeModule()),
        ModularRouter('/login', module: LoginModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
