import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:lhw/main.dart';
import 'package:lhw/notification/notifications_screen.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState
        ?.pushNamed('/notification_screen', arguments: message);
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print("Token: $fCMToken");
    // FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    initPushNotifications();
  }

  Future initPushNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
