import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/helpers/plan_helper.dart';
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
    final weeklyDiscount = PlanHelper.calculateWeeklyDiscount(
      plan.pricePerDay,
      plan.pricePerWeek,
    );
    final monthlyDiscount = PlanHelper.calculateMonthlyDiscount(
      plan.pricePerDay,
      plan.pricePerMonth,
    );

    return PlanState(
      plan: plan,
      percentagePlanDiscountWeekly: weeklyDiscount,
      percentagePlanDiscountMonthly: monthlyDiscount,
    );
  }

  /// Get price based on selected period
  int getPriceForPeriod(PlanPeriod period) =>
      PlanHelper.getPriceForPeriod(plan, period);

  /// Get discount percentage based on selected period
  double getDiscountForPeriod(PlanPeriod period) =>
      PlanHelper.getDiscountForPeriod(
        period,
        percentagePlanDiscountWeekly,
        percentagePlanDiscountMonthly,
      );

  /// Get original price (daily rate multiplied by period)
  int getOriginalPriceForPeriod(PlanPeriod period) =>
      PlanHelper.getOriginalPriceForPeriod(plan, period);
}
