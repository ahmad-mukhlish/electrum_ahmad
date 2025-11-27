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
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildThumbnail(colorScheme),
              const SizedBox(width: 12),
              Expanded(
                child: _buildContent(context, colorScheme, textTheme),
              ),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: _buildModelName(textTheme, colorScheme)),
            const SizedBox(width: 8),
            _buildStatusBadge(colorScheme, textTheme),
          ],
        ),
        const SizedBox(height: 6),
        _buildDateRange(textTheme, colorScheme),
        const SizedBox(height: 4),
        _buildPickupArea(textTheme, colorScheme),
        const SizedBox(height: 6),
        _buildPrice(textTheme, colorScheme),
      ],
    );
  }

  Widget _buildModelName(TextTheme textTheme, ColorScheme colorScheme) {
    return Text(
      rentState.rent.bikeModel,
      style: kIsWeb
          ? textTheme.headlineSmall?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            )
          : textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildStatusBadge(ColorScheme colorScheme, TextTheme textTheme) {
    final statusColor = rentState.getStatusColor(colorScheme);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kIsWeb ? 16 : 8,
        vertical: kIsWeb ? 6 : 4,
      ),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        rentState.statusLabel,
        style: kIsWeb
            ? textTheme.bodyLarge?.copyWith(
                color: statusColor,
                fontWeight: FontWeight.w600,
              )
            : textTheme.labelSmall?.copyWith(
                color: statusColor,
                fontWeight: FontWeight.w600,
              ),
      ),
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
        Text(
          '${rentState.formattedDateRange} (${rentState.totalDays} days)',
          style: kIsWeb
              ? textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                )
              : textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
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
          size: kIsWeb ? 18 : 14,
          color: colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            rentState.rent.pickupText,
            style: kIsWeb
                ? textTheme.bodyLarge?.copyWith(
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
          ? textTheme.headlineSmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            )
          : textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
    );
  }
}
