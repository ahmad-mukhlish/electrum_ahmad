import 'package:flutter/material.dart';

import '../../../domain/entities/bike.dart';
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
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
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
                    child: Column(
                      children: [
                        const RentalPeriodFields(),
                        const SizedBox(height: 24),
                        const PickupLocationField(),
                        const SizedBox(height: 24),
                        const ContactFields(),
                      ],
                    ),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    flex: 2,
                    child: PaymentSummaryCard(bike: bike),
                  ),
                ],
              ),
              const SizedBox(height: 48),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: SubmitButton(bike: bike),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
