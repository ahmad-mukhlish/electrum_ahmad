import 'package:flutter/material.dart';

import '../../../../bikes/domain/entities/bike.dart';
import '../shared/bike_summary_card.dart';
import '../shared/contact_fields.dart';
import '../shared/payment_summary_card.dart';
import '../shared/pickup_location_field.dart';
import '../shared/rental_period_fields.dart';
import '../shared/submit_button.dart';

class RentFormContentMobile extends StatelessWidget {
  const RentFormContentMobile({
    super.key,
    required this.bike,
  });

  final Bike bike;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BikeSummaryCard(bike: bike),
          const SizedBox(height: 20),
          const RentalPeriodFields(),
          const SizedBox(height: 20),
          const PickupLocationField(),
          const SizedBox(height: 20),
          const ContactFields(),
          const SizedBox(height: 20),
          PaymentSummaryCard(bike: bike),
          const SizedBox(height: 32),
          SubmitButton(bike: bike),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
