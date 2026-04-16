import 'package:dazone/app/router/route_data.dart';

/// {@template route_info}
/// The information that's used for pushing a screen
/// {@endtemplate}
class RouteInfo {
  ///{@macro route_info}
  RouteInfo({
    required this.route,
    this.data,
    this.rootNavigator = false,
  });

  /// The screen type
  ///
  final Type route;

  /// The data was passed into this screen
  final RouteData? data;

  /// Whether this screen is pushed by root navigator
  ///
  /// Default is false
  final bool rootNavigator;

  /// The copy function
  RouteInfo copyWith({
    Type? route,
    RouteData? data,
    bool? rootNavigator,
    bool? animation,
  }) {
    return RouteInfo(
      route: route ?? this.route,
      data: data ?? this.data,
      rootNavigator: rootNavigator ?? this.rootNavigator,
    );
  }
}
