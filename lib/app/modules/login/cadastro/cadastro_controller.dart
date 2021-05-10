import 'package:cuidapet_curso/app/services/usuario_service.dart';
import 'package:cuidapet_curso/app/shared/components/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';

part 'cadastro_controller.g.dart';

class CadastroController = _CadastroControllerBase with _$CadastroController;

abstract class _CadastroControllerBase with Store {
  final UsuarioService _service;

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmaSenhaController = TextEditingController();

  @observable
  bool esconderSenha = true;

  @observable
  bool esconderConfirmaSenha = true;

  _CadastroControllerBase(this._service);

  @action
  void mostrarSenha() => esconderSenha = !esconderSenha;

  @action
  void mostrarConfirmaSenha() => esconderConfirmaSenha = !esconderConfirmaSenha;

  @action
  Future<void> cadastrarUsuario() async {
    if (formKey.currentState.validate()) {
      Loader.show();
      try {
        await _service.cadastrarUsuario(
            loginController.text, senhaController.text);
        Loader.hide();
        Modular.to.pop();
      } catch (e) {
        Loader.hide();
        print(e);
        Get.snackbar('Erro', 'Erro ao cadastrar usuário');
      }
    }
  }
}
