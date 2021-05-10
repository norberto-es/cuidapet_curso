import 'dart:io';

import 'package:cuidapet_curso/app/shared/components/facebook_button.dart';
import 'package:cuidapet_curso/app/shared/theme.utils.dart';

import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:get/get.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  //use 'controller' variable to access controller
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //  Get.snackbar('teste', 'teste');
    });
  }

  // Future<void> testeConnection() async {
  //   var db = await Connection().instance;
  //   var resultado = await db.rawQuery('select * from endereco');
  //   print('resultado   $resultado');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeUtils.primaryColor,
      body: SingleChildScrollView(
        child: Container(
          width: ScreenUtil.screenWidthDp,
          height: ScreenUtil.screenHeightDp,
          child: Stack(
            children: [
              Container(
                width: ScreenUtil.screenWidthDp,
                height: ScreenUtil.screenHeightDp < 700
                    ? 800
                    : ScreenUtil.screenHeightDp * .95,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'lib/assets/images/login_background.png'),
                        fit: BoxFit.fill)),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: Platform.isIOS
                        ? ScreenUtil.statusBarHeight + 30
                        : ScreenUtil.statusBarHeight),
                width: double.infinity,
                child: Column(
                  children: [
                    Image.asset(
                      'lib/assets/images/logo.png',
                      width: ScreenUtil().setWidth(400),
                      fit: BoxFit.fill,
                    ),
                    //             Text(DotEnv().env['profile']),
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
      padding: const EdgeInsets.all(5.0),
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
                  borderRadius: BorderRadius.circular(50),
                  gapPadding: 0,
                ),
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Login Obrigatorio';
                }
                return null;
              },
            ),
            SizedBox(height: 8),
            Observer(builder: (_) {
              return TextFormField(
                controller: controller.senhaController,
                obscureText: controller.obscureText,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(fontSize: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    gapPadding: 0,
                  ),
                  suffixIcon: IconButton(
                      onPressed: () => controller.mostarSenhaUsuario(),
                      icon: Icon(Icons.lock)),
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Senha Obrigatoria';
                  } else if (value.length < 6) {
                    return 'senha precisa ter por lo menso 6 caracteres';
                  }
                  return null;
                },
              );
            }),
            Container(
              padding: EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () => controller.login(),
                child: Text(
                  'Entrar',
                  style: TextStyle(fontSize: 15),
                ),
                style: ElevatedButton.styleFrom(
                  primary: ThemeUtils.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: ThemeUtils.primaryColor,
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'ou',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ThemeUtils.primaryColor),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: ThemeUtils.primaryColor,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
            ),
            FacebookButton(onTap: () => controller.facebookLogin()),
            TextButton(
              onPressed: () => Modular.link.pushNamed('/cadastro'),
              child: Text(
                'Cadastrese',
                style: TextStyle(color: ThemeUtils.primaryColorDark),
              ),
              style: TextButton.styleFrom(
                  shadowColor: ThemeUtils.primaryColorDark),
            ),
          ],
        ),
      ),
    );
  }
}
