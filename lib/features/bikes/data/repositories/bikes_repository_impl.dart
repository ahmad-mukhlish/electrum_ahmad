import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/bike.dart';
import '../../domain/repositories/bikes_repository.dart';
import '../datasources/bikes_firestore_datasource.dart';
import '../dtos/bike_dto.dart';

part 'bikes_repository_impl.g.dart';

@riverpod
BikesRepository bikesRepository(Ref ref) {
  final datasource = ref.watch(bikesFirestoreDatasourceProvider);
  return BikesRepositoryImpl(datasource);
}

class BikesRepositoryImpl implements BikesRepository {
  final BikesFirestoreDatasource _datasource;

  BikesRepositoryImpl(this._datasource);

  @override
  Stream<List<Bike>> getBikes() {
    try {
      return _datasource.getBikes().map(
            (dtos) => dtos.map((dto) => dto.toEntity()).toList(),
          );
    } catch (e) {
      rethrow;
    }
  }
}
