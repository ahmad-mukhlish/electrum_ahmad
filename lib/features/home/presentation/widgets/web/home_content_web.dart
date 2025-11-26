import 'package:flutter/material.dart';

import '../shared/promotions_carousel.dart';

class HomeContentWeb extends StatelessWidget {
  const HomeContentWeb({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final carouselHeight = _calculateCarouselHeight(screenHeight);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 16),
            SizedBox(width: double.infinity,child: Text("Promotions", style: Theme.of(context).textTheme.headlineLarge,),),
            PromotionsCarousel(
              isWeb: true,
              height: carouselHeight,
            ),
            const SizedBox(height: 32),
          ],
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
