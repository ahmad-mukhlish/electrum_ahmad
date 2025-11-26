import 'package:flutter/material.dart';

import '../mobile/auth_screen_mobile.dart';
import '../shared/auth_form.dart';

class AuthScreenWeb extends StatelessWidget {
  const AuthScreenWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive: collapse to single column on narrow screens
        if (constraints.maxWidth < 800) return const AuthScreenMobile();
        return _buildWebLayout(context);
      },
    );
  }

  Widget _buildWebLayout(BuildContext context) {
    return Row(
      children: [
        // Left side - Form
        Flexible(
          flex: 2,
          child: const Padding(
            padding: EdgeInsets.all(36.0),
            child: AuthForm(isWebView: true),
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
