import 'package:flutter/material.dart';

import '../../../../../core/widgets/header_web.dart';
import 'plans_section_web.dart';
import '../shared/promotions_carousel.dart';

class HomeContentWeb extends StatelessWidget {
  const HomeContentWeb({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final carouselHeight = _calculateCarouselHeight(screenHeight);

    return Semantics(
      label: "Home screen",
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const HeaderWeb(title: 'For You'),
              const SizedBox(height: 16),
              PromotionsCarousel(isWeb: true, height: carouselHeight),
              const SizedBox(height: 24),
              const HeaderWeb(title: 'Plans'),
              const PlansSectionWeb(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  /// Calculate responsive carousel height for web
  /// Uses percentage of screen height with min/max constraints
  double _calculateCarouselHeight(double screenHeight) {
    final height = screenHeight * 0.25;
    return height.clamp(180.0, 250.0);
  }
}
