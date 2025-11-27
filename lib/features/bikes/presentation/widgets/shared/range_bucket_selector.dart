import 'package:flutter/material.dart';

import '../../viewmodel/states/filter_buckets.dart';

class RangeBucketSelector extends StatelessWidget {
  final RangeBucket? selectedBucket;
  final ValueChanged<RangeBucket?> onChanged;

  const RangeBucketSelector({
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
      children: RangeBucket.values.map((bucket) {
        final isSelected = selectedBucket == bucket;
        return InkWell(
          onTap: () {
            // Allow unselect by clicking the same option
            if (isSelected) {
              onChanged(null);
            } else {
              onChanged(bucket);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
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
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bucket.label,
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSecondary,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                      Text(
                        bucket.description,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSecondary.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
