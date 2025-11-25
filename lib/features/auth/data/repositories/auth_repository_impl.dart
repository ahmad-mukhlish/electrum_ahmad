import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';

part 'auth_repository_impl.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  final datasource = ref.watch(authLocalDatasourceProvider);
  return AuthRepositoryImpl(datasource);
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDatasource _datasource;

  AuthRepositoryImpl(this._datasource);

  @override
  Future<bool> login(String email, String password) async {
    if (email == 'alice@gmail.com' && password == '123456') {
      await _datasource.saveLoginState(true);
      return true;
    }
    throw Exception('Invalid credentials');
  }

  @override
  Future<void> logout() async {
    await _datasource.saveLoginState(false);
  }

  @override
  Future<bool> isLoggedIn() async {
    return _datasource.getLoginState();
  }
}
