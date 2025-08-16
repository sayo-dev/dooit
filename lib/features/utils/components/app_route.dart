import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/model.dart';
import '../../screens/home/home.dart';
import '../../screens/home/to_do/create_new_list.dart';
import '../../screens/home/to_do/search_task.dart';
import '../../screens/home/to_do/task.dart';
import '../../screens/welcome.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class AppRoute {
  static const String welcome = '/welcome';
  static const String home = '/home';
  static const String newList = '/new-list';
  static const String task = '/task';
  static const String search = '/search';

  static final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRoute.welcome,
    routes: [
      GoRoute(
        path: welcome,
        name: welcome,
        builder: (context, state) => const Welcome(),
      ),
      GoRoute(
        path: home,
        name: home,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const Home(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: newList,
        name: newList,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: CreateNewList(pinned: state.extra as bool),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: task,
        name: task,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: Task(task: state.extra as ListDetails),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: search,
        name: search,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: SearchTask(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(-1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      ),
    ],
  );
}
