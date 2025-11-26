import 'package:flutter/material.dart';

import 'plans_section_mobile.dart';
import '../shared/promotions_carousel.dart';

class HomeContentMobile extends StatelessWidget {
  const HomeContentMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            PromotionsCarousel(),
            SizedBox(height: 16),
            PlansSectionMobile(),
          ],
        ),
      ),
    );
  }
}
