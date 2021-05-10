import 'dart:io';

import 'package:cuidapet_curso/app/repository/shared_prefs_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushMessageConfigure {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future<void> configure() async {
    if (Platform.isIOS) {
      await _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
    var deviceId = await _fcm.getToken();
    final prefs = await SharedPrefsRepository.instance;
    await prefs.registerDeviceId(deviceId);
  }
}
