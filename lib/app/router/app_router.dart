import 'package:dazone/features/login/view/login_screen.dart';
import 'package:dazone/features/main/view/main_screen.dart';
import 'package:dazone/features/splash/view/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const main = '/main';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => SplashScreen(),
    ),

    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => LoginScreen(),
    ),

    GoRoute(
      path: AppRoutes.main,
      builder: (context, state) => MainScreen(),
    ),
  ],
);
