import 'package:flutter/material.dart';

import '../shared/promotions_carousel.dart';

class HomeContentMobile extends StatelessWidget {
  const HomeContentMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          PromotionsCarousel(),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}
