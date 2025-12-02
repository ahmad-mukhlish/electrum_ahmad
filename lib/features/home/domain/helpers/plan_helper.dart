import '../entities/plan/plan.dart';
import '../entities/plan/plan_period.dart';

/// Helper class for Plan-related calculations and utilities
class PlanHelper {
  /// Calculate weekly discount percentage
  /// Formula: ((dailyPrice * 7) - weeklyPrice) / (dailyPrice * 7) * 100
  static double calculateWeeklyDiscount(int pricePerDay, int pricePerWeek) {
    if (pricePerDay == 0) return 0.0;

    final weeklyAtDailyRate = pricePerDay * 7;
    if (weeklyAtDailyRate == 0) return 0.0;

    final discount =
        ((weeklyAtDailyRate - pricePerWeek) / weeklyAtDailyRate) * 100;
    return discount.clamp(0.0, 100.0);
  }

  /// Calculate monthly discount percentage
  /// Formula: ((dailyPrice * 30) - monthlyPrice) / (dailyPrice * 30) * 100
  static double calculateMonthlyDiscount(int pricePerDay, int pricePerMonth) {
    if (pricePerDay == 0) return 0.0;

    final monthlyAtDailyRate = pricePerDay * 30;
    if (monthlyAtDailyRate == 0) return 0.0;

    final discount =
        ((monthlyAtDailyRate - pricePerMonth) / monthlyAtDailyRate) * 100;
    return discount.clamp(0.0, 100.0);
  }

  /// Get price based on selected period
  static int getPriceForPeriod(Plan plan, PlanPeriod period) {
    switch (period) {
      case PlanPeriod.daily:
        return plan.pricePerDay;
      case PlanPeriod.weekly:
        return plan.pricePerWeek;
      case PlanPeriod.monthly:
        return plan.pricePerMonth;
    }
  }

  /// Get discount percentage based on selected period
  static double getDiscountForPeriod(
    PlanPeriod period,
    double weeklyDiscount,
    double monthlyDiscount,
  ) {
    switch (period) {
      case PlanPeriod.daily:
        return 0.0; // No discount for daily
      case PlanPeriod.weekly:
        return weeklyDiscount;
      case PlanPeriod.monthly:
        return monthlyDiscount;
    }
  }

  /// Get original price (daily rate multiplied by period)
  static int getOriginalPriceForPeriod(Plan plan, PlanPeriod period) {
    switch (period) {
      case PlanPeriod.daily:
        return plan.pricePerDay;
      case PlanPeriod.weekly:
        return plan.pricePerDay * 7;
      case PlanPeriod.monthly:
        return plan.pricePerDay * 30;
    }
  }
}
