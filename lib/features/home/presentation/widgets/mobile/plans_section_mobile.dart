import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/utils/color_helper.dart';
import '../../../../../core/utils/snackbar_helper.dart';
import '../../viewmodel/notifier/plan/plans_state_provider.dart';
import '../shared/plan_card.dart';
import 'period_toggle_section.dart';

class PlansSectionMobile extends HookConsumerWidget {
  const PlansSectionMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansAsync = ref.watch(plansStateProvider);

    return plansAsync.when(
      data: (planStates) {
        if (planStates.isEmpty) {
          return const SizedBox.shrink();
        }

        return Semantics(
          label: "Plan section",
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(context),
              const SizedBox(height: 8),
              const PeriodToggleSection(),
              const SizedBox(height: 16),
              ...planStates.map((planState) {
                final backgroundColor = hexToColor(planState.plan.hexColor);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: PlanCard(
                    planState: planState,
                    backgroundColor: backgroundColor,
                  ),
                );
              }),
            ],
          ),
        );
      },
      loading: () => _buildLoadingState(),
      error: (error, _) {
        SnackbarHelper.showError(
          context,
          error.toString(),
        );
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildSectionTitle(BuildContext context) {
    return Text(
      'Plans',
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSecondary,
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
