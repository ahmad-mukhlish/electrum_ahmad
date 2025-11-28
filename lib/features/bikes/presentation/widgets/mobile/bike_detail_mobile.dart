import 'package:flutter/material.dart';

import '../../../domain/entities/bike.dart';
import '../shared/bike_cta_button.dart';
import '../shared/bike_hero_section.dart';
import '../shared/bike_service_center_areas.dart';
import '../shared/bike_specs_row.dart';

class BikeDetailMobile extends StatelessWidget {
  const BikeDetailMobile({super.key, required this.bike});

  final Bike bike;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BikeHeroSection(bike: bike),
        BikeSpecsRow(bike: bike),
        const SizedBox(height: 24),
        BikeServiceCenterAreas(serviceCenterAreas: bike.serviceCenterAreas),
        const SizedBox(height: 32),
        Spacer(),
        BikeCTAButton(bike: bike),
        const SizedBox(height: 24),
      ],
    );
  }
}
