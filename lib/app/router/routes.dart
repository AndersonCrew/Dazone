import '../../features/login/view/login_screen.dart';
import '../../features/main/view/main_screen.dart';
import '../../features/splash/view/splash_screen.dart';

/// {@template routes}
/// Stores route's name of this application
/// {@endtemplate}
class Routes {
  ///{@macro routes}
  Routes._();

  /// Represents the route's name for [SplashScreen]
  static const String defaultRoute = '/';

  /// Routes name for home [HomeScreen]
  static const String home = '/home';

  /// Route name for events log [EventsLogView]
  static const String login = '/login';


  /// Route map
  static final Map<Type, String> routeMaps = {
    SplashScreen: defaultRoute,
    LoginScreen: login,
    MainScreen: home,
  };
}
