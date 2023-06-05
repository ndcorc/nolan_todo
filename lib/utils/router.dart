import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:go_router/go_router.dart';
import 'package:nolan_todo/utils/app_drawer.dart';
import 'package:nolan_todo/views/details.dart';
import 'package:nolan_todo/views/simple_todo.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();
// GoRouter configuration
final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (
        BuildContext context,
        GoRouterState state,
        Widget child,
      ) {
        return Scaffold(body: AppDrawer(child: child));
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (context, state) => SimpleTodo(),
        ),
        GoRoute(
          path: '/details',
          builder: (context, state) => const Details(label: 'A'),
        ),
      ],
    ),
  ],
);
