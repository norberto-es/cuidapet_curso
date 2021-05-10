import 'package:cuidapet_curso/app/services/endereco_services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final EnderecoServices _enderecoService;

  _HomeControllerBase(
    this._enderecoService,
  );

  @action
  Future<void> initPage() async {
    await temEnderecoCadastrado();
  }

  Future<void> temEnderecoCadastrado() async {
    var temEndereco = await _enderecoService.existeEnderecoCadastrado();
    if (!temEndereco) {
      await Modular.link.pushNamed('/enderecos');
    }
  }
}
