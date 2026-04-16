import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String appBoxName = 'app_box';
  Future<void> init() async {
    await Hive.openBox(appBoxName);
  }

  Box<dynamic> get _box => Hive.box<dynamic>(appBoxName);

  Future<void> put(String key, dynamic value) async {
    await _box.put(key, value);
  }

  T? get<T>(String key) {
    return _box.get(key) as T?;
  }

  Future<void> delete(String key) async {
    await _box.delete(key);
  }

  Future<void> clear() async {
    await _box.clear();
  }

  List<T> getList<T>(String key) {
    final value = _box.get(key);
    if (value is List) {
      return value.cast<T>();
    }
    return <T>[];
  }
}