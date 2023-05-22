
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'local_notification_service.dart';

class FcmService {
  FcmService(this.localNotificationService);

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final LocalNotificationService localNotificationService;

  final BehaviorSubject<RemoteMessage> onMessageOpenedApp = BehaviorSubject();
  final BehaviorSubject<RemoteMessage> onInitialMessage = BehaviorSubject();

  Future initialize() async {
    _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    final token = await getFcmToken();
    debugPrint(token);

    //when app is in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      localNotificationService.showNotification(message);
    });

    //when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      onMessageOpenedApp.add(message);
    });

    // When open app from terminated
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        onInitialMessage.add(message);
      }
    });
  }

  Future<String?> getFcmToken() async {
    String? fcmKey = await FirebaseMessaging.instance.getToken();
    return fcmKey;
  }
}
