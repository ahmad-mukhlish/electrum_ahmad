import 'package:electrum_ahmad/features/home/data/dtos/plans/plan_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/plan/plan.dart';
import '../../domain/repositories/plans_repository.dart';
import '../datasources/plans/plans_firestore_datasource.dart';

part 'plans_repository_impl.g.dart';

@riverpod
PlansRepository plansRepository(Ref ref) {
  final datasource = ref.watch(plansFirestoreDatasourceProvider);
  return PlansRepositoryImpl(datasource);
}

class PlansRepositoryImpl implements PlansRepository {
  final PlansFirestoreDatasource _datasource;

  PlansRepositoryImpl(this._datasource);

  @override
  Stream<List<Plan>> getPlans() {
    try {
      return _datasource.getPlans().map(
            (dtos) => dtos.map((dto) => dto.toEntity()).toList(),
          );
    } catch (e) {
      rethrow;
    }
  }
}
