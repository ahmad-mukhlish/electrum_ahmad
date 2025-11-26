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

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colorScheme.primary.withValues(alpha: 0.1),
            colorScheme.onPrimary,
          ],
        ),
      ),
      child: Column(
        children: [
          _buildImage(colorScheme),
          Padding(
            padding: EdgeInsets.all(kIsWeb ? 32 : 24),
            child: Column(
              children: [
                Text(
                  bike.model,
                  style:
                      (kIsWeb
                              ? textTheme.displayMedium
                              : textTheme.headlineLarge)
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSecondary,
                          ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: kIsWeb ? 12 : 8),
                Text(
                  _getBikeSubtitle(),
                  style:
                      (kIsWeb ? textTheme.headlineSmall : textTheme.bodyLarge)
                          ?.copyWith(
                            color: colorScheme.onSecondary.withValues(
                              alpha: 0.7,
                            ),
                          ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(ColorScheme colorScheme) {
    return Container(
      height: kIsWeb ? 400 : 250,
      width: double.infinity,
      color: colorScheme.onPrimary.withValues(alpha: 0.5),
      child: bike.photoUrl.isEmpty
          ? Icon(
              Icons.two_wheeler,
              size: kIsWeb ? 120 : 80,
              color: colorScheme.primary,
            )
          : Image.network(
              bike.photoUrl,
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => Icon(
                Icons.two_wheeler,
                size: kIsWeb ? 120 : 80,
                color: colorScheme.primary,
              ),
              loadingBuilder: (_, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
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
