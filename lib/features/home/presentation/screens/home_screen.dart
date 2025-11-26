import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../widgets/mobile/home_content_mobile.dart';
import '../widgets/web/home_content_web.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: kIsWeb ? null : _buildAppBar(context),
      body: kIsWeb ? const HomeContentWeb() : const HomeContentMobile(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      title: Text(
        textAlign: TextAlign.start,
        'For you',
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
    );
  }
}
