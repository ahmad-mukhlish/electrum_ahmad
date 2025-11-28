import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:electrum_ahmad/core/utils/snackbar_helper.dart';
import '../../viewmodel/states/plan_state.dart';
import 'plan_pricing.dart';

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

    return Semantics(
      label: "Plan card",
      child: Card(
        elevation: 4,
        color: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(textTheme, colorScheme),
              _buildTagline(textTheme, colorScheme),
              PlanPricing(planState: planState),
              const SizedBox(height: 4),
              _buildBestFor(textTheme, colorScheme),
              const SizedBox(height: 8),
              _buildSubscribeButton(context, colorScheme),
              const SizedBox(height: 16),
              _buildTerms(textTheme, colorScheme),
            ],
          ),
        ),
      ),
    );
  }

  Text _buildBestFor(TextTheme textTheme, ColorScheme colorScheme) {
    return Text(
      planState.plan.bestFor,
      style: textTheme.bodyMedium?.copyWith(color: colorScheme.onPrimary),
    );
  }

  Widget _buildHeader(TextTheme textTheme, ColorScheme colorScheme) {
    return Row(
      children: [
        Text(
          planState.plan.name.toUpperCase(),
          style: textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildTagline(TextTheme textTheme, ColorScheme colorScheme) {
    return Text(
      planState.plan.tagline,
      style: textTheme.bodyLarge?.copyWith(color: colorScheme.onPrimary),
    );
  }

  Widget _buildSubscribeButton(BuildContext context, ColorScheme colorScheme) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: () {
          SnackbarHelper.showInfo(
            context,
            'TBA (Out of Scope)',
            semanticsLabel: 'Plan subscribe info',
          );
        },
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.secondary,
          foregroundColor: colorScheme.onSecondary,
          padding: EdgeInsets.symmetric(vertical: kIsWeb ? 16 : 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          'Subscribe',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: colorScheme.onSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildTerms(TextTheme textTheme, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: planState.plan.terms
          .map(
            (term) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 20,
                    color: colorScheme.onPrimary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      term,
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
