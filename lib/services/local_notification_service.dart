import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'navigation_service.dart';

class LocalNotificationService {
  LocalNotificationService(this.navigationService);

  final NavigationService navigationService;

  final FlutterLocalNotificationsPlugin _notificationPlugin =
      FlutterLocalNotificationsPlugin();

  void initialize() {
    const InitializationSettings initialSettings = InitializationSettings(
      android: AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      ),
      iOS: DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
      )
    );

    _notificationPlugin.initialize(initialSettings,
        onDidReceiveNotificationResponse: (NotificationResponse details) {
      navigationService.getRouter().go(details.payload ?? '/');
    });
  }

  void showNotification(RemoteMessage message) {
    const NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'com.example.push_notification',
        'push_notification',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    _notificationPlugin.show(
      DateTime.now().microsecond,
      message.notification!.title,
      message.notification!.body,
      notificationDetails,
      payload: message.data['open_url'],
    );
  }
}
