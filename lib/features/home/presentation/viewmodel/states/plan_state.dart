import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/plan/plan.dart';
import '../../../domain/entities/plan/plan_period.dart';

part 'plan_state.freezed.dart';

@freezed
abstract class PlanState with _$PlanState {
  const PlanState._();

  const factory PlanState({
    required Plan plan,
    required double percentagePlanDiscountWeekly,
    required double percentagePlanDiscountMonthly,
  }) = _PlanState;

  /// Create PlanState from Plan entity with calculated discounts
  factory PlanState.fromPlan(Plan plan) {
    final weeklyDiscount = _calculateWeeklyDiscount(
      plan.pricePerDay,
      plan.pricePerWeek,
    );
    final monthlyDiscount = _calculateMonthlyDiscount(
      plan.pricePerDay,
      plan.pricePerMonth,
    );

    return PlanState(
      plan: plan,
      percentagePlanDiscountWeekly: weeklyDiscount,
      percentagePlanDiscountMonthly: monthlyDiscount,
    );
  }
  //TODO @ahmad-mukhlis IS THIS REALLY THE ONLY WAY?
  //TODO @ahmad-mukhlis LIKE DUDE, SERIOUSLY?

  /// Calculate weekly discount percentage
  /// Formula: ((dailyPrice * 7) - weeklyPrice) / (dailyPrice * 7) * 100
  static double _calculateWeeklyDiscount(int pricePerDay, int pricePerWeek) {
    if (pricePerDay == 0) return 0.0;

    final weeklyAtDailyRate = pricePerDay * 7;
    if (weeklyAtDailyRate == 0) return 0.0;

    final discount =
        ((weeklyAtDailyRate - pricePerWeek) / weeklyAtDailyRate) * 100;
    return discount.clamp(0.0, 100.0);
  }

  /// Calculate monthly discount percentage
  /// Formula: ((dailyPrice * 30) - monthlyPrice) / (dailyPrice * 30) * 100
  static double _calculateMonthlyDiscount(
      int pricePerDay, int pricePerMonth) {
    if (pricePerDay == 0) return 0.0;

    final monthlyAtDailyRate = pricePerDay * 30;
    if (monthlyAtDailyRate == 0) return 0.0;

    final discount =
        ((monthlyAtDailyRate - pricePerMonth) / monthlyAtDailyRate) * 100;
    return discount.clamp(0.0, 100.0);
  }

  /// Get price based on selected period
  int getPriceForPeriod(PlanPeriod period) {
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
  double getDiscountForPeriod(PlanPeriod period) {
    switch (period) {
      case PlanPeriod.daily:
        return 0.0; // No discount for daily
      case PlanPeriod.weekly:
        return percentagePlanDiscountWeekly;
      case PlanPeriod.monthly:
        return percentagePlanDiscountMonthly;
    }
  }

  /// Get original price (daily rate multiplied by period)
  int getOriginalPriceForPeriod(PlanPeriod period) {
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
