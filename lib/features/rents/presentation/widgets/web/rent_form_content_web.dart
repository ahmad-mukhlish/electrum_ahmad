import 'package:flutter/material.dart';

import '../../../../bikes/domain/entities/bike.dart';
import '../shared/bike_summary_card.dart';
import '../shared/contact_fields.dart';
import '../shared/payment_summary_card.dart';
import '../shared/pickup_location_field.dart';
import '../shared/rental_period_fields.dart';
import '../shared/submit_button.dart';

class RentFormContentWeb extends StatelessWidget {
  const RentFormContentWeb({
    super.key,
    required this.bike,
  });

  final Bike bike;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BikeSummaryCard(bike: bike),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Card(
                  elevation: 2,
                  color: colorScheme.onPrimary,
                  child: const Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        RentalPeriodFields(),
                        SizedBox(height: 24),
                        PickupLocationField(),
                        SizedBox(height: 24),
                        ContactFields(),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    PaymentSummaryCard(bike: bike),
                    const SizedBox(height: 24),
                    SubmitButton(bike: bike),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
