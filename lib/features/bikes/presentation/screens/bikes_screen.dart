import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/header_web.dart';
import '../../../../core/widgets/primary_app_bar.dart';
import '../widgets/mobile/bikes_filters_mobile.dart';
import '../widgets/web/bikes_filters_web.dart';

class BikesScreen extends StatelessWidget {
  const BikesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.onPrimary,
      appBar: kIsWeb ? null : const PrimaryAppBar(title: 'Bikes'),
      body: Semantics(
        label: "Bike screen",
        child: Column(
          children: [
            if (kIsWeb) Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24, top: 24),
              child: const HeaderWeb(title: 'Bikes'),
            ),
            Expanded(
              child: kIsWeb
                  ? const BikesFiltersWeb()
                  : const BikesFiltersMobile(),
            ),
          ],
        ),
      ),
    );
  }
}
