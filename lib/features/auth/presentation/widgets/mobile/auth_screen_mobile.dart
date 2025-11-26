import 'package:flutter/material.dart';

import '../shared/auth_form.dart';

class AuthScreenMobile extends StatelessWidget {
  const AuthScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Image section - portrait crop at top
            SizedBox(
              height: screenHeight * 0.3,
              width: double.infinity,
              child: Image.asset(
                'assets/images/login.png',
                fit: BoxFit.cover,
              ),
            ),
            // Form section
            Padding(
              padding: const EdgeInsets.all(24),
              child: const AuthForm(),
            ),
          ],
        ),
      ),
    );
  }
}
