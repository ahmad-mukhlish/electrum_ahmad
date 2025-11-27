import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'local_db_service.g.dart';

@riverpod
Future<SharedPreferences> sharedPreferences(Ref ref) async {
  return await SharedPreferences.getInstance();
}

@riverpod
LocalDbService localDbService(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider).value!;
  return LocalDbService(prefs);
}

class LocalDbService {
  final SharedPreferences _prefs;

  LocalDbService(this._prefs);

  Future<void> save(String key, String value) async {
    await _prefs.setString(key, value);
  }

  String? get(String key) {
    return _prefs.getString(key);
  }

  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
