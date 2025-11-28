import 'package:flutter/material.dart';

import '../../../domain/entities/bike.dart';
import '../shared/bike_cta_button.dart';
import '../shared/bike_hero_section.dart';
import '../shared/bike_service_center_areas.dart';
import '../shared/bike_specs_row.dart';

class BikeDetailWeb extends StatelessWidget {
  const BikeDetailWeb({super.key, required this.bike});

  final Bike bike;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: BikeHeroSection(bike: bike),
            ),
            BikeCTAButton(bike: bike),
            const SizedBox(height: 32),
            BikeSpecsRow(bike: bike),
            const SizedBox(height: 32),
            BikeServiceCenterAreas(serviceCenterAreas: bike.serviceCenterAreas),
          ],
        ),
      ),
    );
  }
}
