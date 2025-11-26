import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../viewmodel/notifier/plan/selected_period_provider.dart';
import '../shared/period_toggle.dart';

/// Separate widget for period toggle to avoid rebuilding entire section.
class PeriodToggleSection extends ConsumerWidget {
  const PeriodToggleSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPeriod = ref.watch(selectedPeriodProvider);

    return PeriodToggle(
      selectedPeriod: selectedPeriod,
      onPeriodChanged: (period) =>
          ref.read(selectedPeriodProvider.notifier).setPeriod(period),
    );
  }
}
