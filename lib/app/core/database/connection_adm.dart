import 'package:cuidapet_curso/app/core/database/connection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConnectionADM extends WidgetsBindingObserver with Disposable {
  var conn = Connection();
  ConnectionADM() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        conn.closeConnectio();
        break;
      case AppLifecycleState.paused:
        conn.closeConnectio();
        break;
      case AppLifecycleState.detached:
        conn.closeConnectio();
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
