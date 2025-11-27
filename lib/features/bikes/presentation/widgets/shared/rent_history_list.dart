import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/rent.dart';
import '../../viewmodel/states/rent_history_item_state.dart';
import 'rent_history_card.dart';

class RentHistoryList extends StatelessWidget {
  const RentHistoryList({
    super.key,
    required this.rents,
    required this.onRentTap,
  });

  final List<Rent> rents;
  final void Function(Rent) onRentTap;

  @override
  Widget build(BuildContext context) {
    if (rents.isEmpty) {
      return _buildEmptyState(context);
    }

    return _buildList(context);
  }

  Widget _buildEmptyState(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.electric_bike_outlined,
            size: kIsWeb ? 120 : 80,
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No rentals yet',
            style: kIsWeb
                ? textTheme.headlineMedium?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  )
                : textTheme.titleLarge?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kIsWeb ? 48 : 24),
            child: Text(
              'Your future trips will appear here',
              style: kIsWeb
                  ? textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    )
                  : textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: kIsWeb ? 24 : 0,
        vertical: kIsWeb ? 16 : 0,
      ),
      itemCount: rents.length,
      itemBuilder: (context, index) {
        final rent = rents[index];
        final rentState = RentHistoryItemState.fromEntity(rent);

        return Padding(
          padding: EdgeInsets.only(
            left: kIsWeb ? 0 : 0,
            right: kIsWeb ? 0 : 0,
          ),
          child: RentHistoryCard(
            rentState: rentState,
            onTap: () => onRentTap(rent),
          ),
        );
      },
    );
  }
}
