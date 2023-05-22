import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/first_route.dart';
import '../screens/home_route.dart';
import '../screens/second_route.dart';
import 'analytics_service.dart';

class NavigationService {
  final AnalyticsService analyticService;
  late GoRouter _router;

  NavigationService(this.analyticService) {
    _router = GoRouter(
      observers: [analyticService.getAnalyticsObserver()],
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          name: 'Home',
          builder: (BuildContext context, GoRouterState state) {
            return const HomeRoute();
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'first-page',
              name: 'First',
              builder: (BuildContext context, GoRouterState state) {
                return const FirstRoute();
              },
            ),
            GoRoute(
              path: 'second-page',
              name: 'Second',
              builder: (BuildContext context, GoRouterState state) {
                return const SecondRoute();
              },
            ),
          ],
        ),
      ],
    );
  }

  GoRouter getRouter() => _router;
}