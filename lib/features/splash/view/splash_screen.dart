import 'package:dazone/app/router/navigator.dart';
import 'package:dazone/core/di/injector.dart';
import 'package:dazone/core/theme/app_colors.dart';
import 'package:dazone/features/login/view/login_screen.dart';
import 'package:dazone/features/main/view/main_screen.dart';
import 'package:dazone/features/splash/cubit/splash_cubit.dart';
import 'package:dazone/features/splash/navigation/splash_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static Widget newInstance() => BlocProvider(
    create: (context) {
      return SplashCubit(
        secureStorageService: context.secureStorage,
        prefs: context.prefsStorage,
      );
    },
    child: SplashScreen(),
  );

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashCubit get _cubit => context.read<SplashCubit>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state.navigation is SplashNavigateToLogin) {
          context.pushReplacement(RouteInfo(route: LoginScreen));
        } else if (state.navigation is SplashNavigateToMain) {
          context.pushReplacement(RouteInfo(route: MainScreen));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.appBackgroundColor,
          body: Center(
            child: SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                color: AppColors.white,
                strokeWidth: 2,
              ),
            ),
          ),
        );
      },
    );
  }
}
