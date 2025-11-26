import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../widgets/mobile/auth_screen_mobile.dart';
import '../widgets/web/auth_screen_web.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.1),
      body: kIsWeb ? const AuthScreenWeb() : const AuthScreenMobile(),
    );
  }
}
