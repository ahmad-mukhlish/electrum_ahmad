import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../data/repositories/plans_repository_impl.dart';
import '../../states/plan_state.dart';

part 'plans_state_provider.g.dart';

/// Provider that transforms plans to UI states with discount calculations
@riverpod
Stream<List<PlanState>> plansState(Ref ref) {
  final repository = ref.watch(plansRepositoryProvider);

  try {
    return repository.getPlans().map(
      (plans) => plans.map(PlanState.fromPlan).toList(),
    );
  } catch (e) {
    rethrow;
  }
}
