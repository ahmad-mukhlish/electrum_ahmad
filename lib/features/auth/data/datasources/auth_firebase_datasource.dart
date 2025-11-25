import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/firebase_service.dart';
import '../dtos/user_dto.dart';

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
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
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

      // Update display name after account creation
      await userCredential.user?.updateDisplayName(displayName);
      await userCredential.user?.reload();

      // Get updated user with display name
      final updatedUser = _firebaseAuth.currentUser;

      return _userDtoFromFirebase(updatedUser!);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// Sign out current user
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// Get current user if logged in
  UserDto? getCurrentUser() {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) return null;

    return _userDtoFromFirebase(firebaseUser);
  }

  /// Convert Firebase User to UserDto
  UserDto _userDtoFromFirebase(firebase_auth.User user) => UserDto(
        uid: user.uid,
        email: user.email!,
        displayName: user.displayName,
        photoUrl: user.photoURL,
      );

  /// Handle Firebase Auth exceptions and map to user-friendly messages
  String _handleAuthException(firebase_auth.FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'already registered please login';
      case 'user-not-found':
        return 'not registered yet, please sign up';
      case 'wrong-password':
        return 'not registered yet, please sign up';
      case 'invalid-email':
        return 'Invalid email address';
      case 'weak-password':
        return 'Password too weak';
      case 'invalid-credential':
        return 'not registered yet, please sign up';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}
