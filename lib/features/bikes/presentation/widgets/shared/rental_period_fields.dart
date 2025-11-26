import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../viewmodel/notifiers/rent_form_provider.dart';

class RentalPeriodFields extends ConsumerWidget {
  const RentalPeriodFields({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final formState = ref.watch(rentFormProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rental Period',
          style: (kIsWeb ? textTheme.headlineSmall : textTheme.titleLarge)
              ?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSecondary,
          ),
        ),
        SizedBox(height: kIsWeb ? 16 : 12),
        _buildDateField(
          context,
          label: 'From Date',
          value: formState.fromDate,
          onTap: () => _selectFromDate(context, ref, formState.toDate),
        ),
        SizedBox(height: kIsWeb ? 16 : 12),
        _buildDateField(
          context,
          label: 'To Date',
          value: formState.toDate,
          onTap: () => _selectToDate(context, ref, formState.fromDate),
        ),
      ],
    );
  }

  Widget _buildDateField(
    BuildContext context, {
    required String label,
    required DateTime? value,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final displayText =
        value != null ? DateFormat('MMM dd, yyyy').format(value) : label;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: kIsWeb ? 16 : 12,
          vertical: kIsWeb ? 16 : 12,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: colorScheme.onSecondary.withValues(alpha: 0.3),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today,
              color: colorScheme.primary,
              size: kIsWeb ? 20 : 18,
            ),
            SizedBox(width: kIsWeb ? 12 : 8),
            Expanded(
              child: Text(
                displayText,
                style: (kIsWeb ? textTheme.bodyLarge : textTheme.bodyMedium)
                    ?.copyWith(
                  color: value != null
                      ? colorScheme.onSecondary
                      : colorScheme.onSecondary.withValues(alpha: 0.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectFromDate(
    BuildContext context,
    WidgetRef ref,
    DateTime? toDate,
  ) async {
    final now = DateTime.now();
    final lastDate = toDate ?? DateTime(now.year + 1);

    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: lastDate,
    );

    if (picked != null) {
      ref.read(rentFormProvider.notifier).setFromDate(picked);
    }
  }

  Future<void> _selectToDate(
    BuildContext context,
    WidgetRef ref,
    DateTime? fromDate,
  ) async {
    final now = DateTime.now();
    final initialDate = fromDate ?? now;
    final firstDate = fromDate ?? now;

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: DateTime(now.year + 1),
    );

    if (picked != null) {
      ref.read(rentFormProvider.notifier).setToDate(picked);
    }
  }
}
