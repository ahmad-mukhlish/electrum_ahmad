import '../entities/user.dart';

abstract class AuthRepository {
  Future<bool> login(String email, String password);
  Future<bool> register(String email, String password, String displayName);
  Future<void> logout();
  Future<User?> getUser();
}
