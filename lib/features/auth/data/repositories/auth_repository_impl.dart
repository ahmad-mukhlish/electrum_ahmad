import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/firestore/auth_firebase_datasource.dart';
import '../datasources/local/auth_local_datasource.dart';
import '../dtos/user_dto.dart';

part 'auth_repository_impl.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  final localDatasource = ref.watch(authLocalDatasourceProvider);
  final firebaseDatasource = ref.watch(authFirebaseDatasourceProvider);
  return AuthRepositoryImpl(localDatasource, firebaseDatasource);
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDatasource _localDatasource;
  final AuthFirebaseDatasource _firebaseDatasource;

  AuthRepositoryImpl(this._localDatasource, this._firebaseDatasource);

  @override
  Future<bool> login(String email, String password) async {
    try {
      // Call Firebase to authenticate
      final userDto = await _firebaseDatasource.signInWithEmailAndPassword(
        email,
        password,
      );

      // Save user data locally
      await _localDatasource.saveUser(userDto);
      await _localDatasource.saveLoginState(true);

      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> register(
    String email,
    String password,
    String displayName,
  ) async {
    try {
      final userDto = await _firebaseDatasource.signUpWithEmailAndPassword(
        email,
        password,
        displayName,
      );

      // Save user data locally
      await _localDatasource.saveUser(userDto);
      await _localDatasource.saveLoginState(true);
    } catch (e) {
      rethrow;
    }

    return true;
  }

  @override
  Future<void> logout() async {
    try {
      // Sign out from Firebase
      await _firebaseDatasource.signOut();

      // Clear local data
      await _localDatasource.clearUser();
      await _localDatasource.clearLoginState();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User?> getUser() async {
    try {
      // Get user from local storage
      final userDto = _localDatasource.getUser();

      // Convert DTO to entity
      return userDto?.toEntity();
    } catch (e) {
      rethrow;
    }
  }
}
