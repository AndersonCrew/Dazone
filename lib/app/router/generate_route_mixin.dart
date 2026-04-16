import 'package:dazone/app/router/route_data.dart';
import 'package:dazone/app/router/route_info.dart';
import 'package:dazone/app/router/route_result.dart';
import 'package:dazone/app/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/login/view/login_screen.dart';
import '../../features/main/view/main_screen.dart';
import '../../features/splash/view/splash_screen.dart';

/// This [GenerateRouteMixin] helps mapping the [RouteSettings.name] to
/// corresponding screen
mixin GenerateRouteMixin {
  /// Generates the corresponding screen form route's name
  Route<RouteResult?>? onGenerateRoute(RouteSettings settings) {
    final routeInfo = settings.arguments as RouteInfo?;

    final child = _findScreen(settings.name);
    if (child == null) return null;

    return MaterialPageRoute(
      builder: (context) {
        return RepositoryProvider<RouteData?>.value(
          value: routeInfo?.data,
          child: child,
        );
      },
      settings: settings,
    );
  }

  /// Find the corresponding screen by [routeName]
  ///
  /// Returns null if [routeName] is not existing
  Widget? _findScreen(String? routeName) {
    return switch (routeName) {
      Routes.defaultRoute => SplashScreen.newInstance(),
      Routes.login => LoginScreen(),
      Routes.home => MainScreen(),
      (_) => null,
    };
  }
}
