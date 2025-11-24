import 'package:electrum_ahmad/features/auth/presentation/widgets/mobile/login_screen_mobile.dart';
import 'package:flutter/material.dart';

import '../login_form.dart';

class LoginScreenWeb extends StatelessWidget {
  const LoginScreenWeb({super.key, this.onSignIn, this.onSignUp});

  final VoidCallback? onSignIn;
  final VoidCallback? onSignUp;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive: collapse to single column on narrow screens
        if (constraints.maxWidth < 800) return LoginScreenMobile(onSignIn: onSignIn, onSignUp: onSignUp,);
        return buildWebLayout(context);
      },
    );
  }

  Widget buildWebLayout(BuildContext context) {
    return Row(
      children: [
        // Left side - Form
        Flexible(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: LoginForm(onSignIn: onSignIn, onSignUp: onSignUp, isWebView: true,),
          ),
        ),
        // Right side - Image
        Flexible(
          flex: 3,
          child: Image.asset(
            'assets/images/login.png',
            fit: BoxFit.fill,
            height: double.infinity,
          ),
        ),
      ],
    );
  }
}
