import 'package:flutter/material.dart';

import '../../../domain/entities/bike.dart';
import '../shared/bike_cta_button.dart';
import '../shared/bike_hero_section.dart';
import '../shared/bike_pickup_areas.dart';
import '../shared/bike_specs_row.dart';

class BikeDetailMobile extends StatelessWidget {
  const BikeDetailMobile({
    super.key,
    required this.bike,
  });

  final Bike bike;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BikeHeroSection(bike: bike),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BikeSpecsRow(bike: bike),
                const SizedBox(height: 24),
                BikePickupAreas(pickupAreas: bike.pickupAreas),
                const SizedBox(height: 32),
                BikeCTAButton(bike: bike),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
