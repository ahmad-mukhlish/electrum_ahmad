import 'package:flutter/material.dart';

import '../../../domain/entities/bike.dart';
import '../shared/bike_cta_button.dart';
import '../shared/bike_hero_section.dart';
import '../shared/bike_pickup_areas.dart';
import '../shared/bike_specs_row.dart';

class BikeDetailWeb extends StatelessWidget {
  const BikeDetailWeb({
    super.key,
    required this.bike,
  });

  final Bike bike;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BikeHeroSection(bike: bike),
            const SizedBox(height: 32),
            BikeSpecsRow(bike: bike),
            const SizedBox(height: 32),
            BikePickupAreas(pickupAreas: bike.pickupAreas),
            const SizedBox(height: 48),
            Center(
              child: BikeCTAButton(bike: bike),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
