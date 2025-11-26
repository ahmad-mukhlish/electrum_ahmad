import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/utils/color_helper.dart';
import '../../viewmodel/notifier/plan/plans_state_provider.dart';
import '../../viewmodel/notifier/plan/selected_period_provider.dart';
import '../shared/period_toggle.dart';
import '../shared/plan_card.dart';

class PlansSectionWeb extends HookConsumerWidget {
  const PlansSectionWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansAsync = ref.watch(plansStateProvider);

    return plansAsync.when(
      data: (planStates) {
        if (planStates.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context),

            const _PeriodToggleSection(),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: planStates.map((planState) {
                final backgroundColor = hexToColor(planState.plan.hexColor);
                return Expanded(
                  child: PlanCard(
                    planState: planState,
                    backgroundColor: backgroundColor,
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
      loading: () => _buildLoadingState(),
      error: (error, _) {
        // Show error snackbar and hide section
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.toString()),
                backgroundColor: Colors.red,
              ),
            );
          }
        });
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildSectionTitle(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        'Plans',
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Column(
      children: [
        SizedBox(height: 200),
        Center(child: CircularProgressIndicator()),
        SizedBox(height: 200),
      ],
    );
  }
}

/// Separate widget for period toggle to avoid rebuilding entire section
class _PeriodToggleSection extends ConsumerWidget {
  const _PeriodToggleSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPeriod = ref.watch(selectedPeriodProvider);

    return Center(
      child: PeriodToggle(
        selectedPeriod: selectedPeriod,
        onPeriodChanged: (period) =>
            ref.read(selectedPeriodProvider.notifier).setPeriod(period),
      ),
    );
  }
}
