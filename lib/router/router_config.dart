import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_2/home_page.dart';
import 'package:project_2/profile_page.dart';
import 'package:project_2/splash_screen.dart';
import 'router_constants.dart';
import 'package:project_2/games/block_breaker/game_screen.dart';

class MyAppRouter {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: RouteConstants.splashRouteName,
        path: '/',
        pageBuilder: (context, start) {
          return MaterialPage(child: SplashScreen());
        },
      ),

      GoRoute(
        name: RouteConstants.homeRouteName,
        path: '/home_page',
        pageBuilder: (context, start) {
          return MaterialPage(child: HomePage());
        },
      ),

      GoRoute(
        name: RouteConstants.profileRouteName,
        path: '/profile_page',
        pageBuilder: (context, start) {
          return MaterialPage(child: ProfilePage());
        },
      ),

      GoRoute(
        name: RouteConstants.loginRouteName,
        path: '/login_&signup/login_page',
        pageBuilder: (context, start) {
          return MaterialPage(child: HomePage());
        },
      ),

      GoRoute(
        name: 'block_breaker_gamescreen',
        path: '/block_breaker/:level',
        pageBuilder: (context, state) {
          // Extract the level string from path parameters and parse to integer
          final levelString = state.pathParameters['level'] ?? '1';
          final level = int.parse(levelString);
          return MaterialPage(child: GameScreen(level: level));
        },
      ),
    ],
  );
}
