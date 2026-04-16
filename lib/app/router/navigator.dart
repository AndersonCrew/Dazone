import 'package:dazone/app/router/route_data.dart';
import 'package:dazone/app/router/route_info.dart';
import 'package:dazone/app/router/route_result.dart';
import 'package:dazone/app/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'generate_route_mixin.dart';
export 'route_data.dart';
export 'route_info.dart';
export 'route_result.dart';
export 'routes.dart';

/// Custom exception for route argument errors
class RouteArgumentException implements Exception {
  /// {@macro authentication_exception}
  RouteArgumentException(this.message);

  /// The message of [RouteArgumentException]
  final String message;

  @override
  String toString() => 'RouteArgumentException: $message';
}

/// The extension for [Navigator] on [BuildContext]
extension NavigatorExtension on BuildContext {
  NavigatorState _navState({bool? rootNavigator}) =>
      Navigator.of(this, rootNavigator: rootNavigator ?? false);

  ///Push a screen onto the navigator by [routeInfo]
  Future<RouteResult?> push(RouteInfo routeInfo) {
    return _navState(
      rootNavigator: routeInfo.rootNavigator,
    ).pushNamed<RouteResult?>(
      _findRoute(routeInfo.route),
      arguments: routeInfo,
    );
  }

  /// Replace the current screen of the navigator by pushing the new screen
  /// [routeInfo] and then disposing the previous screen once the new screen has
  /// finished animating in.
  ///
  /// [routeResult] is result of the replaced screen
  Future<RouteResult?> pushReplacement(
    RouteInfo routeInfo, {
    RouteResult? routeResult,
  }) {
    return _navState(
      rootNavigator: routeInfo.rootNavigator,
    ).pushReplacementNamed<RouteResult?, RouteResult?>(
      _findRoute(routeInfo.route),
      result: routeResult,
      arguments: routeInfo,
    );
  }

  /// Pop the top-most screen off the navigator
  void pop({RouteResult? routeResult, bool? rootNavigator}) {
    if (_navState(rootNavigator: rootNavigator).canPop()) {
      _navState(rootNavigator: rootNavigator).pop<RouteResult>(routeResult);
    }
  }

  /// Push and remove until match [predicate] condition
  Future<RouteResult?> pushAndRemoveUntil(
    RouteInfo routeInfo,
    RoutePredicate predicate,
  ) {
    return _navState(
      rootNavigator: routeInfo.rootNavigator,
    ).pushNamedAndRemoveUntil<RouteResult?>(
      _findRoute(routeInfo.route),
      predicate,
      arguments: routeInfo,
    );
  }

  /// Push the screen onto the first position of navigator's stack and remove
  /// the rest of screen exception the first screen
  Future<RouteResult?> pushToFirst(RouteInfo routeInfo) {
    return pushAndRemoveUntil(routeInfo, (route) => route.isFirst);
  }

  /// Push the screen onto navigator and remove all of existing screen in
  /// navigator's stack
  Future<RouteResult?> pushToTop(RouteInfo routeInfo) {
    return pushAndRemoveUntil(routeInfo, (route) => false);
  }

  /// Pop until match [RouteInfo.route]
  void popUntilRoute(RouteInfo routeInfo) {
    popUntil(
      ModalRoute.withName(_findRoute(routeInfo.route)),
      rootNavigator: routeInfo.rootNavigator,
    );
  }

  /// Pop until match [RouteInfo.route] or [Route.isFirst]
  void popUntilRouteOrFirst({RouteInfo? routeInfo}) {
    popUntil(
      (route) {
        return routeInfo != null &&
                _findRoute(routeInfo.route) == route.settings.name ||
            route.isFirst;
      },
      rootNavigator: routeInfo?.rootNavigator,
      // dart format tries to remove the trailing comma
      // ignore: require_trailing_commas
    );
  }

  /// Pop until match the [predicate] condition
  void popUntil(RoutePredicate predicate, {bool? rootNavigator}) {
    _navState(rootNavigator: rootNavigator).popUntil(predicate);
  }

  /// Get data from [RouteData.arguments]
  T arguments<T>() {
    try {
      return read<RouteData?>()?.arguments as T;
    } catch (e) {
      throw RouteArgumentException('Failed to cast arguments to $T');
    }
  }

  String _findRoute(Type routeType) {
    var route = Routes.routeMaps[routeType];
    return route!;
  }
}
