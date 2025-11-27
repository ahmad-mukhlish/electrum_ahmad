/// Range buckets for filtering bikes by range in kilometers
enum RangeBucket {
  short,
  medium,
  long;

  /// Check if a range falls within this bucket
  bool contains(int rangeKm) => switch (this) {
        RangeBucket.short => rangeKm < 80,
        RangeBucket.medium => rangeKm >= 80 && rangeKm <= 110,
        RangeBucket.long => rangeKm > 110,
      };

  /// Display label for UI
  String get label => switch (this) {
        RangeBucket.short => 'Short range',
        RangeBucket.medium => 'Medium range',
        RangeBucket.long => 'Long range',
      };

  /// Description for UI
  String get description => switch (this) {
        RangeBucket.short => '< 80 km',
        RangeBucket.medium => '80 - 110 km',
        RangeBucket.long => '> 110 km',
      };
}
