import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../data/repositories/promotions_repository_impl.dart';
import '../../../../domain/entities/promotion/promotion.dart';

part 'promotions_provider.g.dart';

/// Stream provider for real-time promotions
@riverpod
Stream<List<Promotion>> promotions(Ref ref) {
  final repository = ref.watch(promotionsRepositoryProvider);
  return repository.getPromotions();
}
