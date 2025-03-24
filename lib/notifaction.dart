import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> backgroundHandler(RemoteMessage remoteMessage) async {
  log("🔔 Background Notification: ${remoteMessage.notification?.title}");
}

class Noti {
  static Future<void> initialize() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings notificationSettings = await messaging.requestPermission();

    if (notificationSettings.authorizationStatus == AuthorizationStatus.authorized) {
      // Register background message handler
      FirebaseMessaging.onBackgroundMessage(backgroundHandler);

      // Foreground message handler
      FirebaseMessaging.onMessage.listen((message) {
        log("📩 Foreground Notification: ${message.notification?.title}");
      });

      log("✅ Notifications Authorized");
    } else {
      log("❌ Notifications Not Authorized");
    }
  }
}
