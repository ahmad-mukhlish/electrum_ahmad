import 'package:flutter/material.dart';

import '../../viewmodel/states/filter_buckets.dart';

class PriceBucketSelector extends StatelessWidget {
  final PriceBucket? selectedBucket;
  final ValueChanged<PriceBucket?> onChanged;

  const PriceBucketSelector({
    super.key,
    required this.selectedBucket,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: PriceBucket.values
          .map(
            (bucket) => _buildBucketOption(
              bucket: bucket,
              colorScheme: colorScheme,
              textTheme: textTheme,
            ),
          )
          .toList(),
    );
  }

  Widget _buildBucketOption({
    required PriceBucket bucket,
    required ColorScheme colorScheme,
    required TextTheme textTheme,
  }) {
    final isSelected = selectedBucket == bucket;

    return InkWell(
      onTap: () => _handleTap(bucket, isSelected),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            _buildSelectionIndicator(colorScheme, isSelected),
            const SizedBox(width: 8),
            Expanded(
              child: _buildTextSection(
                bucket: bucket,
                colorScheme: colorScheme,
                textTheme: textTheme,
                isSelected: isSelected,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionIndicator(ColorScheme colorScheme, bool isSelected) =>
      Container(
        width: 20,
        height: 20,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.onSecondary.withValues(alpha: 0.5),
            width: 2,
          ),
        ),
        child: isSelected
            ? Center(
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.primary,
                  ),
                ),
              )
            : null,
      );

  Widget _buildTextSection({
    required PriceBucket bucket,
    required ColorScheme colorScheme,
    required TextTheme textTheme,
    required bool isSelected,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        bucket.label,
        style: textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSecondary,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      Text(
        bucket.description,
        style: textTheme.bodySmall?.copyWith(
          color: colorScheme.onSecondary.withValues(alpha: 0.7),
        ),
      ),
    ],
  );

  void _handleTap(PriceBucket bucket, bool isSelected) =>
      isSelected ? onChanged(null) : onChanged(bucket);
}
