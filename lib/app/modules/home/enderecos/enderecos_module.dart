import 'package:cuidapet_curso/app/modules/home/enderecos/enderecos_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cuidapet_curso/app/modules/home/enderecos/enderecos_page.dart';

class EnderecosModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => EnderecosController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => EnderecosPage()),
      ];

  static Inject get to => Inject<EnderecosModule>.of();
}
