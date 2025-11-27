import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../bikes/domain/entities/bike.dart';
import '../../viewmodel/notifiers/form/rent_form_provider.dart';
import '../../viewmodel/notifiers/submit/rent_submit_provider.dart';

class SubmitButton extends ConsumerWidget {
  const SubmitButton({
    super.key,
    required this.bike,
  });

  final Bike bike;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final formState = ref.watch(rentFormProvider);
    final submitState = ref.watch(rentSubmitProvider);

    final isValid = formState.isValid;
    final isLoading = submitState.isLoading;

    return FilledButton(
      onPressed: (isValid && !isLoading) ? () => _onSubmit(ref) : null,
      style: FilledButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        disabledBackgroundColor: colorScheme.onSecondary.withValues(alpha: 0.3),
        disabledForegroundColor: colorScheme.onSecondary.withValues(alpha: 0.5),
        padding: EdgeInsets.symmetric(vertical: kIsWeb ? 20 : 16),
        minimumSize: const Size(double.infinity, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: isLoading
          ? SizedBox(
              height: kIsWeb ? 24 : 20,
              width: kIsWeb ? 24 : 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: colorScheme.onPrimary,
              ),
            )
          : Text(
              'Send request',
              style:
                  (kIsWeb ? textTheme.headlineSmall : textTheme.bodyLarge)
                      ?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onPrimary,
              ),
            ),
    );
  }

  void _onSubmit(WidgetRef ref) {
    final formState = ref.read(rentFormProvider);
    ref.read(rentSubmitProvider.notifier).submitRent(bike, formState);
  }
}
