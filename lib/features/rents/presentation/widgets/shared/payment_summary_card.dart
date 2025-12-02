import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/utils/price_formatter.dart';
import '../../../../bikes/domain/entities/bike.dart';
import '../../viewmodel/notifiers/form/rent_form_provider.dart';

class PaymentSummaryCard extends ConsumerWidget {
  const PaymentSummaryCard({super.key, required this.bike});

  final Bike bike;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final formState = ref.watch(rentFormProvider);

    final totalDays = formState.totalDays;
    final totalAmount = formState.totalAmount(bike.pricePerDay);

    return Card(
      elevation: 3,
      color: colorScheme.secondary,
      child: Padding(
        padding: EdgeInsets.all(kIsWeb ? 24 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Summary',
              style: (kIsWeb ? textTheme.headlineSmall : textTheme.titleLarge)
                  ?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSecondary,
                  ),
            ),
            SizedBox(height: kIsWeb ? 20 : 16),
            if (totalDays > 0) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price per day',
                    style: (kIsWeb ? textTheme.bodyLarge : textTheme.bodyMedium)
                        ?.copyWith(
                          color: colorScheme.onSecondary.withValues(alpha: 0.8),
                        ),
                  ),
                  Text(
                    PriceFormatter.formatToRupiahK(bike.pricePerDay),
                    style: (kIsWeb ? textTheme.bodyLarge : textTheme.bodyMedium)
                        ?.copyWith(
                          color: colorScheme.onSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
              SizedBox(height: kIsWeb ? 12 : 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total days',
                    style: (kIsWeb ? textTheme.bodyLarge : textTheme.bodyMedium)
                        ?.copyWith(
                          color: colorScheme.onSecondary.withValues(alpha: 0.8),
                        ),
                  ),
                  Text(
                    '$totalDays ${totalDays == 1 ? 'day' : 'days'}',
                    style: (kIsWeb ? textTheme.bodyLarge : textTheme.bodyMedium)
                        ?.copyWith(
                          color: colorScheme.onSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
              SizedBox(height: kIsWeb ? 16 : 12),
              Divider(
                color: colorScheme.onSecondary.withValues(alpha: 0.2),
                thickness: 1,
              ),
              SizedBox(height: kIsWeb ? 16 : 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount',
                    style:
                        (kIsWeb
                                ? textTheme.headlineSmall
                                : textTheme.titleMedium)
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSecondary,
                            ),
                  ),
                  Text(
                    PriceFormatter.formatToRupiahK(totalAmount),
                    style:
                        (kIsWeb
                                ? textTheme.headlineSmall
                                : textTheme.titleMedium)
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSecondary,
                            ),
                  ),
                ],
              ),
            ] else
              Text(
                'Select rental dates to see payment summary',
                style: (kIsWeb ? textTheme.bodyLarge : textTheme.bodyMedium)
                    ?.copyWith(
                      color: colorScheme.onSecondary.withValues(alpha: 0.6),
                      fontStyle: FontStyle.italic,
                    ),
              ),
          ],
        ),
      ),
    );
  }
}
