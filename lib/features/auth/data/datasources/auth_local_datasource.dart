import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/local_db_service.dart';

part 'auth_local_datasource.g.dart';

@riverpod
AuthLocalDatasource authLocalDatasource(Ref ref) {
  final localDb = ref.watch(localDbServiceProvider);
  return AuthLocalDatasource(localDb);
}

class AuthLocalDatasource {
  final LocalDbService _localDb;
  static const _keyLoggedIn = 'isLoggedIn';

  AuthLocalDatasource(this._localDb);

  Future<void> saveLoginState(bool isLoggedIn) async {
    await _localDb.save(_keyLoggedIn, isLoggedIn.toString());
  }

  bool getLoginState() {
    final value = _localDb.get(_keyLoggedIn);
    return value == 'true';
  }

  Future<void> clearLoginState() async {
    await _localDb.clearAll();
  }
}
