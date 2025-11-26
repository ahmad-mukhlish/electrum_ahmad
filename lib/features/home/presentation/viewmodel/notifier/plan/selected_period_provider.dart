import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/entities/plan/plan_period.dart';

part 'selected_period_provider.g.dart';

/// Provider for managing the selected plan period
@riverpod
class SelectedPeriod extends _$SelectedPeriod {
  @override
  PlanPeriod build() => PlanPeriod.monthly;

  void setPeriod(PlanPeriod period) => state = period;
}
