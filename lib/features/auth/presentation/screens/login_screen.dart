import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../widgets/mobile/login_screen_mobile.dart';
import '../widgets/web/login_screen_web.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _handleSignIn() {
    // TODO: Implement sign in logic
    debugPrint('Sign in pressed');
  }

  void _handleSignUp() {
    // TODO: Implement sign up navigation
    debugPrint('Sign up pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: kIsWeb
          ? LoginScreenWeb(onSignIn: _handleSignIn, onSignUp: _handleSignUp)
          : LoginScreenMobile(onSignIn: _handleSignIn, onSignUp: _handleSignUp),
    );
  }
}
