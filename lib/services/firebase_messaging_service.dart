import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    String? token = await _messaging.getToken();
    print("FCM token: $token");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

      _localNotifications.show(
        message.hashCode,
        message.notification?.title,
        message.notification?.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'fcm_channel',
            'Firebase Notifications',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
      );
    });
  }
}
