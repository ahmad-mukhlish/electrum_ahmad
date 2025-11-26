import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/plan/plan.dart';


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
}
