import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/local_db_service.dart';
import '../dtos/user_dto.dart';

part 'auth_local_datasource.g.dart';

@riverpod
AuthLocalDatasource authLocalDatasource(Ref ref) {
  final localDb = ref.watch(localDbServiceProvider);
  return AuthLocalDatasource(localDb);
}

class AuthLocalDatasource {
  final LocalDbService _localDb;
  static const _keyLoggedIn = 'isLoggedIn';
  static const _keyUser = 'user';

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

  /// Save user data as JSON string
  Future<void> saveUser(UserDto user) async {
    final jsonString = jsonEncode(user.toJson());
    await _localDb.save(_keyUser, jsonString);
  }

  /// Get user data from local storage
  UserDto? getUser() {
    final jsonString = _localDb.get(_keyUser);
    if (jsonString == null) return null;

    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return UserDto.fromJson(json);
    } catch (e) {
      // Return null if JSON parsing fails
      return null;
    }
  }

  /// Clear user data from local storage
  Future<void> clearUser() async {
    await _localDb.save(_keyUser, '');
  }
}
