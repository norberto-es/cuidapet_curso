import 'dart:convert';

import 'package:cuidapet_curso/app/models/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsRepository {
  static const _ACCESS_TOKEN = '/_ACCESS_TOKEN/';
  static const _DEVICE_ID = '/DEVICE_ID/';
  static const _DADOS_USUARIO = '/_DADOS_USUARIO/';
  //static const _ENDERECO_SELECIONADO = '/_ENDERECO_SELECIONADO/';
  //
  static SharedPreferences prefs;
  static SharedPrefsRepository _instanceRepository;
  SharedPrefsRepository._();

  static Future<SharedPrefsRepository> get instance async {
    prefs ??= await SharedPreferences.getInstance();
    _instanceRepository ??= SharedPrefsRepository._();
    return _instanceRepository;
  }

  Future<void> registerAccessToken(String token) async {
    await prefs.setString(_ACCESS_TOKEN, token);
  }

  String get accessToken => prefs.get(_ACCESS_TOKEN);

  Future<void> registerDeviceId(String deviceID) async {
    await prefs.setString(_DEVICE_ID, deviceID);
  }

  String get deviceID => prefs.get(_DEVICE_ID);

  Future<void> registerDadosUsuario(UsuarioModel usuario) async {
    await prefs.setString(_DADOS_USUARIO, jsonEncode(usuario));
  }

  UsuarioModel get dadosUsuario {
    if (prefs.containsKey(_DADOS_USUARIO)) {
      Map<String, dynamic> usuarioMapa =
          jsonDecode(prefs.getString(_DADOS_USUARIO));
      return UsuarioModel.fromJson(usuarioMapa);
    }

    return null;
  }

  Future<void> logout() async {
    await prefs.clear();
    await Modular.to.pushNamedAndRemoveUntil('/', ModalRoute.withName('/'));
    // prefs.remove(_ACCESS_TOKEN);
    // prefs.remove(_DADOS_USUARIO);
    // prefs.remove(_ENDERECO_SELECIONADO);
  }
}
