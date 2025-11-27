import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../data/repositories/plans/plans_repository_impl.dart';
import '../../../../domain/entities/plan/plan.dart';

/// Stream provider for real-time plans
@riverpod
Stream<List<Plan>> plans(Ref ref) {
  final repository = ref.watch(plansRepositoryProvider);
  return repository.getPlans();
}
