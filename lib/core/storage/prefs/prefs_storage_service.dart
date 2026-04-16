import 'package:shared_preferences/shared_preferences.dart';

class PrefsStorageService {
  PrefsStorageService(this._prefs);

  final SharedPreferencesAsync _prefs;

  static const _onboardingDoneKey = 'onboarding_done';
  static const _baseUrlKey = 'base_url';

  Future<bool> checkAndMarkOnboardingDone() async {
    final isDone = await _prefs.getBool(_onboardingDoneKey) ?? false;

    if (!isDone) {
      await _prefs.setBool(_onboardingDoneKey, true);
    }

    return isDone;
  }

  Future<void> resetOnboarding() async {
    await _prefs.remove(_onboardingDoneKey);
  }

  ///*Base URL*////
  /// Domain
  Future<void> saveBaseUrl(String baseUrl) async {
    await _prefs.setString(_baseUrlKey, baseUrl);
  }

  Future<String?> getBaseUrl() async {
    return _prefs.getString(_baseUrlKey);
  }

  Future<void> clearBaseUrl() async {
    await _prefs.remove(_baseUrlKey);
  }

  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
