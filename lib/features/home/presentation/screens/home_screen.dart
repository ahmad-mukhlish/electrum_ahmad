import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../../../../core/widgets/primary_app_bar.dart';
import '../widgets/mobile/home_content_mobile.dart';
import '../widgets/web/home_content_web.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: kIsWeb ? null : const PrimaryAppBar(title: 'For you'),
      body: kIsWeb ? const HomeContentWeb() : const HomeContentMobile(),
    );
  }
}
