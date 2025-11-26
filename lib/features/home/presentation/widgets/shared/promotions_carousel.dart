import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../viewmodel/notifier/promotion/promotions_provider.dart';
import 'promotion_card.dart';

class PromotionsCarousel extends HookConsumerWidget {
  final bool isWeb;
  final double? height;

  const PromotionsCarousel({
    super.key,
    this.isWeb = false,
    this.height,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final promotionsAsync = ref.watch(promotionsProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return promotionsAsync.when(
      data: (promotions) {
        if (promotions.isEmpty) {
          return const SizedBox.shrink();
        }

        return CarouselSlider.builder(
          itemCount: promotions.length,
          itemBuilder: (context, index, realIndex) {
            final promotion = promotions[index];
            final backgroundColor = _getBackgroundColor(colorScheme, index);

            return PromotionCard(
              promotion: promotion,
              backgroundColor: backgroundColor,
            );
          },
          options: _buildCarouselOptions(promotions.length),
        );
      },
      loading: () => _buildLoadingState(),
      error: (error, _) {
        // Show error snackbar and hide carousel
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.toString()),
                backgroundColor: Colors.red,
              ),
            );
          }
        });
        return const SizedBox.shrink();
      },
    );
  }

  CarouselOptions _buildCarouselOptions(int itemCount) {
    final carouselHeight = height ?? 250.0;

    if (isWeb) {
      return CarouselOptions(
        height: carouselHeight,
        viewportFraction: 0.18,
        initialPage: 0,
        enableInfiniteScroll: itemCount > 1,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 8),
        autoPlayAnimationDuration: const Duration(seconds: 1),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: false,
      );
    }

    // Mobile options
    return CarouselOptions(
      height: carouselHeight,
      aspectRatio: 16 / 9,
      viewportFraction: 0.8,
      initialPage: 0,
      enableInfiniteScroll: itemCount > 1,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 8),
      autoPlayAnimationDuration: const Duration(seconds: 1),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      enlargeFactor: 0.2,
    );
  }

  Widget _buildLoadingState() {
    final carouselHeight = height ?? 200.0;
    return SizedBox(
      height: carouselHeight,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  /// Cycle through theme colors with adjusted alpha for text visibility
  Color _getBackgroundColor(ColorScheme colorScheme, int index) {
    final colors = [
      colorScheme.primary,
      colorScheme.secondary,
      colorScheme.tertiary,
    ];

    final selectedColor = colors[index % colors.length];
    return selectedColor;
  }
}
