import '../entities/plan/plan.dart';

abstract class PlansRepository {
  Stream<List<Plan>> getPlans();
}
