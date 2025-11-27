/// Price buckets for filtering bikes by daily rental price
enum PriceBucket {
  budget,
  premium,
  deluxe;

  /// Check if a price falls within this bucket
  bool contains(int pricePerDay) => switch (this) {
        PriceBucket.budget => pricePerDay <= 30000,
        PriceBucket.premium => pricePerDay > 30000 && pricePerDay <= 60000,
        PriceBucket.deluxe => pricePerDay > 60000,
      };

  /// Display label for UI
  String get label => switch (this) {
        PriceBucket.budget => 'Budget',
        PriceBucket.premium => 'Premium',
        PriceBucket.deluxe => 'Deluxe',
      };

  /// Description for UI
  String get description => switch (this) {
        PriceBucket.budget => '≤ Rp 30k',
        PriceBucket.premium => 'Rp 30k - 60k',
        PriceBucket.deluxe => '> Rp 60k',
      };
}

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
