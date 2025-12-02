/// Enum representing different subscription periods for plans
//TODO @ahmad-mukhlis isn't ENUM should be on separate folder?
enum PlanPeriod {
  daily,
  weekly,
  monthly;

  /// Get display label for the period
  String get label {
    switch (this) {
      case PlanPeriod.daily:
        return 'Daily';
      case PlanPeriod.weekly:
        return 'Weekly';
      case PlanPeriod.monthly:
        return 'Monthly';
    }
  }

  /// Get the period unit text (e.g., "/ day", "/ week", "/ month")
  String get unitText {
    switch (this) {
      case PlanPeriod.daily:
        return '/ day';
      case PlanPeriod.weekly:
        return '/ week';
      case PlanPeriod.monthly:
        return '/ month';
    }
  }
}
