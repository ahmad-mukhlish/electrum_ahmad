import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../viewmodel/states/rent_history_item_state.dart';

class RentHistoryCard extends StatelessWidget {
  const RentHistoryCard({
    super.key,
    required this.rentState,
    required this.onTap,
  });

  final RentHistoryItemState rentState;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 2,
      color: colorScheme.secondary,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildThumbnail(colorScheme),
              const SizedBox(width: 12),
              Flexible(child: _buildContent(context, colorScheme, textTheme)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnail(ColorScheme colorScheme) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: rentState.rent.photoUrl != null
          ? CachedNetworkImage(
              imageUrl: rentState.rent.photoUrl!,
              width: kIsWeb ? 100 : 70,
              height: kIsWeb ? 100 : 70,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: kIsWeb ? 100 : 70,
                height: kIsWeb ? 100 : 70,
                color: colorScheme.surfaceContainerHighest,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: colorScheme.primary,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: kIsWeb ? 100 : 70,
                height: kIsWeb ? 100 : 70,
                color: colorScheme.surfaceContainerHighest,
                child: Icon(
                  Icons.electric_bike,
                  color: colorScheme.onSurfaceVariant,
                  size: kIsWeb ? 40 : 30,
                ),
              ),
            )
          : Container(
              width: kIsWeb ? 100 : 70,
              height: kIsWeb ? 100 : 70,
              color: colorScheme.surfaceContainerHighest,
              child: Icon(
                Icons.electric_bike,
                color: colorScheme.onSurfaceVariant,
                size: kIsWeb ? 40 : 30,
              ),
            ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (rentState.rent.bikeModel.isNotEmpty) Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Expanded(child: _buildModelName(textTheme, colorScheme)),
            const SizedBox(width: 16),
          ],
        ),
        const SizedBox(height: 8),
        _buildDateRange(textTheme, colorScheme),
        const SizedBox(height: 4),
        _buildPickupArea(textTheme, colorScheme),
        const SizedBox(height: 8),
        _buildPrice(textTheme, colorScheme),
      ],
    );
  }

  Widget _buildModelName(TextTheme textTheme, ColorScheme colorScheme) {
    return Text(
      rentState.rent.bikeModel,
      style: kIsWeb
          ? textTheme.titleLarge?.copyWith(color: colorScheme.onSurface, fontWeight: FontWeight.w500, fontSize: 18)
          : textTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildDateRange(TextTheme textTheme, ColorScheme colorScheme) {
    return Row(
      children: [
        Icon(
          Icons.calendar_today,
          size: kIsWeb ? 18 : 14,
          color: colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            '${rentState.formattedDateRange} (${rentState.totalDays} days)',
            style: kIsWeb
                ? textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  )
                : textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildPickupArea(TextTheme textTheme, ColorScheme colorScheme) {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          size: kIsWeb ? 16 : 12,
          color: colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            rentState.rent.pickupText,
            style: kIsWeb
                ? textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  )
                : textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildPrice(TextTheme textTheme, ColorScheme colorScheme) {
    return Text(
      rentState.formattedPrice,
      style: kIsWeb
          ? textTheme.titleMedium?.copyWith(color: colorScheme.primary, fontSize: 16, fontWeight: FontWeight.w600)
          : textTheme.titleMedium?.copyWith(color: colorScheme.primary),
    );
  }
}
