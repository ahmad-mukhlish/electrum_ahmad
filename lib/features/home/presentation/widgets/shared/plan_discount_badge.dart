import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../viewmodel/notifier/plan/selected_period_provider.dart';
import '../../viewmodel/states/plan_state.dart';

/// Optimized widget that only rebuilds when selectedPeriod changes.
class PlanDiscountBadge extends ConsumerWidget {
  final PlanState planState;

  const PlanDiscountBadge({super.key, required this.planState});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPeriod = ref.watch(selectedPeriodProvider);
    final textTheme = Theme.of(context).textTheme;

    final discountPercent = planState.getDiscountForPeriod(selectedPeriod);
    if (discountPercent <= 0) return const SizedBox.shrink();

    return Column(
      children: [
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.local_offer, size: 16, color: Colors.white),
              const SizedBox(width: 6),
              Text(
                '${discountPercent.toStringAsFixed(0)}% off',
                style: textTheme.labelMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
