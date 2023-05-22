import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_example/services/fcm_service.dart';
import 'package:firebase_example/services/local_notification_service.dart';
import 'package:firebase_example/services/navigation_service.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();

  locator<LocalNotificationService>().initialize();
  locator<FcmService>().initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  setupInteractedMessage() {
    locator<FcmService>().onInitialMessage.listen((message) {
      print(message.toString());
      locator<NavigationService>()
          .getRouter()
          .go(Uri.parse(message.data['open_url']).path);
    });
    locator<FcmService>().onMessageOpenedApp.listen((message) {
      print(message.toString());
      locator<NavigationService>()
          .getRouter()
          .go(Uri.parse(message.data['open_url']).path);
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setupInteractedMessage();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: locator<NavigationService>().getRouter(),
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}
