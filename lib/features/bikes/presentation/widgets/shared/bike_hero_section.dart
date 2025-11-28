import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/bike.dart';

class BikeHeroSection extends StatelessWidget {
  const BikeHeroSection({super.key, required this.bike});

  final Bike bike;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final titleStyle = kIsWeb
        ? textTheme.displayMedium
        : textTheme.headlineLarge;
    final subtitleStyle = kIsWeb
        ? textTheme.headlineSmall
        : textTheme.bodyLarge;

    return Column(
      children: [
        _buildImage(colorScheme) ,
        Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Text(
                bike.model,
                style: titleStyle?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: kIsWeb ? 12 : 8),
              Text(
                _getBikeSubtitle(),
                style: subtitleStyle?.copyWith(
                  color: colorScheme.onSecondary.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImage(ColorScheme colorScheme) {
    return Container(
      height: kIsWeb ? 600 : 250,
      width: double.infinity,
      color: colorScheme.onPrimary.withValues(alpha: 0.5),
      child: bike.photoUrl.isEmpty
          ? Icon(
              Icons.two_wheeler,
              size: kIsWeb ? 120 : 80,
              color: colorScheme.primary,
            )
          : CachedNetworkImage(
              imageUrl: bike.photoUrl,
              fit: kIsWeb ? BoxFit.contain : BoxFit.contain,
              errorWidget: (_, _, _) => Icon(
                Icons.two_wheeler,
                size: kIsWeb ? 120 : 80,
                color: colorScheme.primary,
              ),
              progressIndicatorBuilder: (_, _, progress) => Center(
                child: CircularProgressIndicator(value: progress.progress),
              ),
            ),
    );
  }

  String _getBikeSubtitle() {
    final modelLower = bike.model.toLowerCase();

    if (modelLower.contains('city')) {
      return 'Urban Commuter';
    } else if (modelLower.contains('cargo')) {
      return 'Heavy Duty Cargo';
    } else if (modelLower.contains('long range')) {
      return 'Long Distance Travel';
    } else if (modelLower.contains('supercharged')) {
      return 'High Performance';
    }

    return 'Electric Scooter';
  }
}
