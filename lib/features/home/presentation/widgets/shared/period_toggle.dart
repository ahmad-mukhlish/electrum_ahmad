import 'package:flutter/material.dart';

import '../../../domain/entities/plan/plan_period.dart';

class PeriodToggle extends StatelessWidget {
  final PlanPeriod selectedPeriod;
  final ValueChanged<PlanPeriod> onPeriodChanged;

  const PeriodToggle({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: PlanPeriod.values.map((period) {
          return _buildPeriodButton(context, period);
        }).toList(),
      ),
    );
  }

  Widget _buildPeriodButton(BuildContext context, PlanPeriod period) {
    final isSelected = selectedPeriod == period;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => onPeriodChanged(period),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          period.label,
          style: textTheme.bodyMedium?.copyWith(
            color: isSelected
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
