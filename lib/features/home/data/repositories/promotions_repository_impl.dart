import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/promotion/promotion.dart';
import '../../domain/repositories/promotions_repository.dart';
import '../datasources/promotions_firestore_datasource.dart';
import '../dtos/promotion_dto.dart';

part 'promotions_repository_impl.g.dart';

@riverpod
PromotionsRepository promotionsRepository(Ref ref) {
  final datasource = ref.watch(promotionsFirestoreDatasourceProvider);
  return PromotionsRepositoryImpl(datasource);
}

class PromotionsRepositoryImpl implements PromotionsRepository {
  final PromotionsFirestoreDatasource _datasource;

  PromotionsRepositoryImpl(this._datasource);

  @override
  Stream<List<Promotion>> getPromotions() {
    try {
      return _datasource.getPromotions().map(
        (dtos) => dtos.map((dto) => dto.toEntity()).toList(),
      );
    } catch (e) {
      rethrow;
    }
  }
}
