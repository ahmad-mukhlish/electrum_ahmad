import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../widgets/mobile/login_screen_mobile.dart';
import '../widgets/web/login_screen_web.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: kIsWeb ? const LoginScreenWeb() : const LoginScreenMobile(),
    );
  }
}
