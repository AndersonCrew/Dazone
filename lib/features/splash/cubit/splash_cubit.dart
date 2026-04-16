import 'package:dazone/core/storage/prefs/prefs_storage_service.dart';
import 'package:dazone/core/storage/secured/secure_storage_service.dart';
import 'package:dazone/core/utils/cubit_mixin.dart';
import 'package:dazone/core/utils/data_load_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../navigation/splash_navigation.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> with CubitMixin {
  SplashCubit({
    required SecureStorageService secureStorageService,
    required PrefsStorageService prefs,
  }) : _secureStorageService = secureStorageService,
       _prefs = prefs,
       super(SplashState());

  final SecureStorageService _secureStorageService;
  final PrefsStorageService _prefs;

  Future<void> init() async {
    safeEmit(state.copyWith(status: DataLoadStatus.loading));
    await Future.delayed(const Duration(seconds: 3));
    final isFirstRun = await _prefs.checkAndMarkOnboardingDone();
    if (isFirstRun) {
      _secureStorageService.deleteAccessToken();
      _secureStorageService.deleteRefreshToken();

      safeEmit(state.copyWith(navigation: SplashNavigateToLogin()));
    }

    final token = await _secureStorageService.readAccessToken();
    final navigation = token != null
        ? SplashNavigateToMain()
        : SplashNavigateToLogin();
    safeEmit(state.copyWith(navigation: navigation));
  }
}
