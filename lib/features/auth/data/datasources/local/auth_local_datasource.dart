import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/services/local_db/local_db_service.dart';
import '../../dtos/user_dto.dart';

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
    try {
      await _localDb.save(_keyLoggedIn, isLoggedIn.toString());
    } catch (e) {
      rethrow;
    }
  }

  bool getLoginState() {
    try {
      final value = _localDb.get(_keyLoggedIn);
      return value == 'true';
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearLoginState() async {
    try {
      await _localDb.clearAll();
    } catch (e) {
      rethrow;
    }
  }

  /// Save user data as JSON string
  Future<void> saveUser(UserDto user) async {
    try {
      final jsonString = jsonEncode(user.toJson());
      await _localDb.save(_keyUser, jsonString);
    } catch (e) {
      rethrow;
    }
  }

  /// Get user data from local storage
  UserDto? getUser() {
    try {
      final jsonString = _localDb.get(_keyUser);
      if (jsonString == null) return null;

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return UserDto.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  /// Clear user data from local storage
  Future<void> clearUser() async {
    try {
      await _localDb.save(_keyUser, '');
    } catch (e) {
      rethrow;
    }
  }
}
