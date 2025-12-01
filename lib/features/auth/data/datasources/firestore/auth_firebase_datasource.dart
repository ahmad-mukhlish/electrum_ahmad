import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/services/firebase/firebase_service.dart';
import '../../dtos/user_dto.dart';

part 'auth_firebase_datasource.g.dart';

@riverpod
AuthFirebaseDatasource authFirebaseDatasource(Ref ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return AuthFirebaseDatasource(firebaseAuth);
}

class AuthFirebaseDatasource {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  AuthFirebaseDatasource(this._firebaseAuth);

  /// Sign in with email and password
  Future<UserDto> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return _userDtoFromFirebase(userCredential.user!);
    } catch (e) {
      rethrow;
    }
  }

  /// Sign up with email and password
  Future<UserDto> signUpWithEmailAndPassword(
    String email,
    String password,
    String displayName,
  ) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      firebase_auth.User? user = userCredential.user;
      if (user == null) throw Error();

      // Update display name
      await user.updateDisplayName(displayName);
      await user.reload();
      user = _firebaseAuth.currentUser;

      return _userDtoFromFirebase(user!);
    } catch (e) {
      rethrow;
    }
  }

  /// Sign out current user
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  /// Get current user if logged in
  UserDto? getCurrentUser() {
    try {
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser == null) return null;

      return _userDtoFromFirebase(firebaseUser);
    } catch (e) {
      rethrow;
    }
  }

  //TODO @ahmad-mukhlis aren't we have the mapping on the entity extension?
  /// Convert Firebase User to UserDto
  UserDto _userDtoFromFirebase(firebase_auth.User user) => UserDto(
        uid: user.uid,
        email: user.email!,
        displayName: user.displayName,
        photoUrl: user.photoURL,
      );
}
