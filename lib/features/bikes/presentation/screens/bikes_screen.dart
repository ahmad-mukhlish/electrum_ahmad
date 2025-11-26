import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/header_web.dart';
import '../../../../core/widgets/primary_app_bar.dart';
import '../widgets/mobile/bikes_list_mobile.dart';
import '../widgets/web/bikes_list_web.dart';

class BikesScreen extends StatelessWidget {
  const BikesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.onPrimary,
      appBar: kIsWeb ? null : const PrimaryAppBar(title: 'Bikes'),
      body: Column(
        children: [
          if (kIsWeb) const HeaderWeb(title: 'Bikes'),
          Expanded(
            child: kIsWeb ? const BikesListWeb() : const BikesListMobile(),
          ),
        ],
      ),
    );
  }
}
