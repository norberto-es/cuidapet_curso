import 'package:cuidapet_curso/app/modules/home/enderecos/enderecos_module.dart';
import 'package:cuidapet_curso/app/modules/home/home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cuidapet_curso/app/modules/home/home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController(i.get())),
        //     Bind((i) => HomeController(i.get(), i.get(), i.get())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => HomePage()),
        ModularRouter('/enderecos', module: EnderecosModule()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
