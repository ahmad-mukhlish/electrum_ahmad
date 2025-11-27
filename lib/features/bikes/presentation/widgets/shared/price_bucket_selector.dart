import 'package:flutter/material.dart';

import '../../viewmodel/states/filter_option.dart';
import '../../viewmodel/states/price_bucket.dart';
import 'filter_selector.dart';

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
    return FilterSelector<PriceBucket>(
      selected: selectedBucket,
      onChanged: onChanged,
      options: PriceBucket.values
          .map(
            (bucket) => FilterOption(
              value: bucket,
              label: bucket.label,
              description: bucket.description,
            ),
          )
          .toList(),
    );
  }
}
