import 'package:connectivity/connectivity.dart';
import 'package:cuidapet_curso/app/core/dio/custom_dio.dart';
import 'package:cuidapet_curso/app/repository/security_storage_repository.dart';
import 'package:cuidapet_curso/app/repository/shared_prefs_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
//import 'package:get/get.dart';

import 'package:synchronized/synchronized.dart' as syncronized;

class AuthInterceptorWrapper extends InterceptorsWrapper {
  syncronized.Lock lock = syncronized.Lock();

  @override
  Future onRequest(RequestOptions options) async {
    final prefs = await SharedPrefsRepository.instance;
    options.headers['Authorization'] = prefs.accessToken;

    if (DotEnv().env['profile'] == 'dev') {
      print('########### Request Log ###########');
      print('url ${options.uri}');
      print('method ${options.method}');
      print('data ${options.data}');
      print('headers ${options.headers}');
    }
  }

  @override
  Future onResponse(Response response) async {
    if (DotEnv().env['profile'] == 'dev') {
      print('########### Request Log ###########');
      print('data: ${response.data}');
    }
  }

  // @override
  // Future onError(DioError err) async {
  //   print(' #' * 10 + '* ERROR *' + ' #' * 10);
  //   print('errr ${err.response}');
  //   if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
  //     await _refreshToken();
  //     print('########### Access Token Atualizado ###########');
  //     final req = err.request;
  //     return CustomDio.authInstance.request(req.path, options: req);
  //   }

  //   return err;
  // }

  @override
  Future onError(DioError err) async {
    print('########### On Error ###########');
    print('error: ${err.response}');

    if (err.type == DioErrorType.RECEIVE_TIMEOUT ||
        err.type == DioErrorType.CONNECT_TIMEOUT) {
      //Get.snackbar('Connection Error',
      //     'O Servidor não está acessível. Verifique sua conexão com a internet e tente novamente');
    } else if (err.type == DioErrorType.RESPONSE) {
      if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
        await _refreshToken();
        print('########### Access Token Atualizado ###########');
        final req = err.request;
        return CustomDio.authInstance.request(req.path, options: req);
      }
    } else if (err.type == DioErrorType.DEFAULT) {
      if (err.message.contains('Network is unreachable')) {
        await lock.synchronized(() async {
          final connectionStatus = await Connectivity().checkConnectivity();
          if (connectionStatus != ConnectivityResult.none) {
            return null;
          } else {
            return await Modular.to.pushNamed('/connection_error');
          }
        });
        final req = err.request;
        return CustomDio.authInstance.request(req.path, options: req);
      }
    }

    // Verificar se deu erro 403 ou 401 fazer o refresh do token

    return err;
  }

  Future<void> _refreshToken() async {
    final prefs = await SharedPrefsRepository.instance;
    final security = SecurityStorageRepository();

    try {
      final refreshToken = await security.refreshToken;
      final accessToken = prefs.accessToken;
      var refreshResult = await CustomDio.instance.put('/login/refresh',
          data: {'token': accessToken, 'refresh_token': refreshToken});

      await prefs.registerAccessToken(refreshResult.data['access_token']);
      await security.registerRefreshToken(refreshResult.data['refresh_token']);
    } catch (e) {
      print(e);
      await prefs.logout();
    }
  }
}
