import 'package:flutter/material.dart';

import '../../viewmodel/states/filter_option.dart';
import '../../viewmodel/states/range_bucket.dart';
import 'filter_selector.dart';

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
    return FilterSelector<RangeBucket>(
      selected: selectedBucket,
      onChanged: onChanged,
      options: RangeBucket.values
          .map(
            (bucket) => FilterOption(
              value: bucket,
              label: bucket.label,
              description: bucket.description,
              semanticLabel: bucket == RangeBucket.long ? "Filter long" : null,
            ),
          )
          .toList(),
    );
  }
}
