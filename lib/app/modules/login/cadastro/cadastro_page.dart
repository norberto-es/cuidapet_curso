import 'package:cuidapet_curso/app/shared/theme.utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'cadastro_controller.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key key}) : super(key: key);

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState
    extends ModularState<CadastroPage, CadastroController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Cadastrar Usuário'),
        elevation: 0,
      ),
      backgroundColor: ThemeUtils.primaryColor,
      body: SingleChildScrollView(
        child: Container(
          width: ScreenUtil.screenWidthDp,
          height: ScreenUtil.screenHeightDp,
          child: Stack(
            children: <Widget>[
              Container(
                width: ScreenUtil.screenWidthDp,
                height: ScreenUtil.screenHeightDp < 700
                    ? 800
                    : ScreenUtil.screenHeightDp * .95,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage('lib/assets/images/login_background.png'),
                      fit: BoxFit.fill),
                ),
              ),
              Container(
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'lib/assets/images/logo.png',
                      width: ScreenUtil().setWidth(400),
                      fit: BoxFit.fill,
                    ),
                    _buildForm()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: controller.loginController,
              decoration: InputDecoration(
                  labelText: 'Login',
                  labelStyle: TextStyle(fontSize: 15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50), gapPadding: 0)),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Login obrigatório';
                } else if (!value.contains('@')) {
                  return 'Login precisa ser um e-mail';
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            Observer(builder: (_) {
              return TextFormField(
                controller: controller.senhaController,
                obscureText: controller.esconderSenha,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(fontSize: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    gapPadding: 0,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => controller.mostrarSenha(),
                    icon: Icon(Icons.lock),
                  ),
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Senha obrigatória';
                  } else if (value.length < 6) {
                    return 'Senha precisa ter pelo menos 6 caracteres';
                  }
                  return null;
                },
              );
            }),
            SizedBox(height: 20),
            Observer(builder: (_) {
              return TextFormField(
                controller: controller.confirmaSenhaController,
                obscureText: controller.esconderConfirmaSenha,
                decoration: InputDecoration(
                  labelText: 'Confirmar Senha',
                  labelStyle: TextStyle(fontSize: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    gapPadding: 0,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => controller.mostrarConfirmaSenha(),
                    icon: Icon(Icons.lock),
                  ),
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Confirma Senha obrigatória';
                  } else if (value.length < 6) {
                    return 'Confirma Senha precisa ter pelo menos 6 caracteres';
                  } else if (value != controller.senhaController.text) {
                    return 'Senha e confirma senha não são iguais';
                  }
                  return null;
                },
              );
            }),
            Container(
              padding: EdgeInsets.all(10),
              height: 60,
              width: double.infinity,
              child: RaisedButton(
                onPressed: () => controller.cadastrarUsuario(),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: ThemeUtils.primaryColor,
                child: Text('Cadastrar',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
