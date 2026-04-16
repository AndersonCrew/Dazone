import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/api_client.dart';
import '../network/dio_factory.dart';
import '../storage/hive/hive_service.dart';
import '../storage/prefs/prefs_storage_service.dart';
import '../storage/secured/secure_storage_service.dart';

final getIt = GetIt.instance;

Future<void> setupInjector() async {
  const secureStorage = FlutterSecureStorage();
  final prefsAsync = SharedPreferencesAsync();

  final hiveService = HiveService();
  await hiveService.init();

  final dioFactory = DioFactory();
  final dio = dioFactory.create();

  getIt.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(secureStorage),
  );

  getIt.registerLazySingleton<PrefsStorageService>(
    () => PrefsStorageService(prefsAsync),
  );

  getIt.registerSingleton<HiveService>(hiveService);

  getIt.registerLazySingleton<DioFactory>(() => dioFactory);

  getIt.registerLazySingleton<Dio>(() => dio);

  getIt.registerLazySingleton<ApiClient>(
    () => ApiClient(
      dio: getIt<Dio>(),
      prefsStorageService: getIt<PrefsStorageService>(),
    ),
  );
}

extension InjectorBuildContextExtension on BuildContext {
  T di<T extends Object>() => getIt<T>();

  SecureStorageService get secureStorage => di<SecureStorageService>();

  PrefsStorageService get prefsStorage => di<PrefsStorageService>();

  HiveService get hiveStorage => di<HiveService>();

  Dio get dio => di<Dio>();
  ApiClient get apiClient => di<ApiClient>();
}
