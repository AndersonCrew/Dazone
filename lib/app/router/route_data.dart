/// {@template route_data}
/// The class that stores data of screen
/// {@endtemplate}
class RouteData {
  ///{@macro route_data}
  RouteData({this.arguments});

  /// Represent the value of argument
  final Object? arguments;

  /// The copy function
  RouteData copyWith({Object? arguments}) {
    return RouteData(
      arguments: arguments ?? this.arguments,
    );
  }
}
