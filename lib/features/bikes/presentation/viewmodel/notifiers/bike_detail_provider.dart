import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/repositories/bikes_repository_impl.dart';
import '../../../domain/entities/bike.dart';

part 'bike_detail_provider.g.dart';

/// Provider for fetching a single bike by ID
/// Returns Stream Bike from Firestore for real-time updates
@riverpod
Stream<Bike?> bikeDetail(Ref ref, String bikeId) {
  final repository = ref.watch(bikesRepositoryProvider);
  return repository.getBikeById(bikeId);
}
