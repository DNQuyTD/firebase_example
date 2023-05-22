import 'package:firebase_example/services/fcm_service.dart';
import 'package:firebase_example/services/local_notification_service.dart';
import 'package:firebase_example/services/navigation_service.dart';
import 'package:get_it/get_it.dart';

import 'services/analytics_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AnalyticsService());
  locator.registerLazySingleton(() => LocalNotificationService(locator()));
  locator.registerLazySingleton(() => FcmService(locator()));

  locator.registerLazySingleton(() => NavigationService(locator()));
}
