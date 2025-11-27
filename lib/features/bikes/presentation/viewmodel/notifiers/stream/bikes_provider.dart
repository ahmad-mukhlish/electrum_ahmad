import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../data/repositories/bikes_repository_impl.dart';
import '../../../../domain/entities/bike.dart';

part 'bikes_provider.g.dart';

/// Provider that streams bikes from Firestore
@riverpod
Stream<List<Bike>> bikes(Ref ref) {
  final repository = ref.watch(bikesRepositoryProvider);

  try {
    return repository.getBikes();
  } catch (e) {
    rethrow;
  }
}
