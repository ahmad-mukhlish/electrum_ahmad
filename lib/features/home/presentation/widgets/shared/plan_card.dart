import 'package:flutter/material.dart';

import '../../viewmodel/states/plan_state.dart';


class PlanCard extends StatelessWidget {
  final PlanState planState;
  final Color backgroundColor;

  const PlanCard({
    super.key,
    required this.planState,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 4,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(textTheme),
            const SizedBox(height: 8),
            _buildTagline(textTheme),
            const SizedBox(height: 16),
            _buildDiscountBadge(textTheme),
            const SizedBox(height: 12),
            _buildPricing(textTheme),
            const SizedBox(height: 16),
            _buildSubscribeButton(colorScheme),
            const SizedBox(height: 24),
            _buildTerms(textTheme),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(TextTheme textTheme) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          size: 24,
          color: Colors.white,
        ),
        const SizedBox(width: 8),
        Text(
          planState.plan.name,
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildTagline(TextTheme textTheme) {
    return Text(
      planState.plan.bestFor,
      style: textTheme.bodyMedium?.copyWith(
        color: Colors.white70,
      ),
    );
  }

  Widget _buildDiscountBadge(TextTheme textTheme) {
    final discountPercent = planState.percentagePlanDiscountMonthly;
    if (discountPercent <= 0) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.local_offer,
            size: 16,
            color: Colors.white,
          ),
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
    );
  }

  Widget _buildPricing(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '\$${planState.plan.pricePerMonth}',
              style: textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                '/ month',
                style: textTheme.bodyLarge?.copyWith(
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          '\$${planState.plan.pricePerMonth * 12} / year',
          style: textTheme.bodyMedium?.copyWith(
            color: Colors.white60,
          ),
        ),
      ],
    );
  }

  Widget _buildSubscribeButton(ColorScheme colorScheme) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: () {},
        style: FilledButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Subscribe',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildTerms(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: planState.plan.terms
          .map((term) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      size: 20,
                      color: Colors.white70,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        term,
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
