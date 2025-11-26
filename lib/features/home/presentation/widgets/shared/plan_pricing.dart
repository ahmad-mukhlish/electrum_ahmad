import 'package:electrum_ahmad/features/home/presentation/widgets/shared/plan_discount_badge.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/utils/price_formatter.dart';
import '../../viewmodel/notifier/plan/selected_period_provider.dart';
import '../../viewmodel/states/plan_state.dart';

/// Optimized widget that only rebuilds when selectedPeriod changes.
class PlanPricing extends ConsumerWidget {
  final PlanState planState;

  const PlanPricing({super.key, required this.planState});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPeriod = ref.watch(selectedPeriodProvider);
    final textTheme = Theme.of(context).textTheme;

    final textWhiteColor = Theme.of(context).colorScheme.onPrimary;
    final currentPrice = planState.getPriceForPeriod(selectedPeriod);
    final originalPrice = planState.getOriginalPriceForPeriod(selectedPeriod);
    final hasDiscount = planState.getDiscountForPeriod(selectedPeriod) > 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              formatPriceToRupiahK(currentPrice),
              style: textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                selectedPeriod.unitText,
                style: textTheme.bodyLarge?.copyWith(color: textWhiteColor),
              ),
            ),
          ],
        ),
        if (hasDiscount) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${formatPriceToRupiahK(originalPrice)} ${selectedPeriod.unitText}',
                style: textTheme.bodyMedium?.copyWith(
                  color: Colors.white60,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: 8),
              PlanDiscountBadge(planState: planState),
            ],
          ),
        ],
      ],
    );
  }
}
