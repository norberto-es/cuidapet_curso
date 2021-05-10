import 'package:cuidapet_curso/app/core/exception/cuidapet_exceptions.dart';
import 'package:cuidapet_curso/app/shared/components/loader.dart';
import 'package:cuidapet_curso/app/services/usuario_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final UsuarioService _service;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController loginController =
      TextEditingController(); //igual al video

  TextEditingController senhaController = TextEditingController();
  @observable
  bool obscureText = true;

  _LoginControllerBase(this._service);

  @action
  void mostarSenhaUsuario() {
    obscureText = !obscureText;
  }
  //norberto.pn2@gmail.com
  //njpn3000@gmail.com

  @action
  Future<void> login() async {
    if (formKey.currentState.validate()) {
      try {
        Loader.show();
        await _service.login(false,
            email: loginController.text, senha: senhaController.text);
        Loader.hide();
        await Modular.to.pushReplacementNamed('/');
        // await Modular.to.pushNamed('/');
        // await Get.offAllNamed('/');
      } on AcessoNegadoException catch (e) {
        Loader.hide();
        print(e);
        Get.snackbar('Erro', 'Login e senha inválidos');
      } catch (e) {
        Loader.hide();
        print(e);
        Get.snackbar('Erro', 'Erro ao realizar login');
      }
    }
  }

  Future<void> facebookLogin() async {
    try {
      Loader.show();
      await _service.login(true);
      Loader.hide();
      await Modular.to.pushNamed('/');
    } on AcessoNegadoException catch (e) {
      Loader.hide();
      print(e);
      Get.snackbar('Erro', 'Login e senha inválidos');
    } catch (e) {
      Loader.hide();
      print(e);
      Get.snackbar('Erro', 'Erro ao realizar login');
    }
  }
}
