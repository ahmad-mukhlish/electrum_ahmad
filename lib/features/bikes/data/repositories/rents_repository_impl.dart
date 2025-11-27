import 'package:electrum_ahmad/features/bikes/data/dtos/rent_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/rent.dart';
import '../../domain/repositories/rents_repository.dart';
import '../datasources/rents_firestore_datasource.dart';

part 'rents_repository_impl.g.dart';

@riverpod
RentsRepository rentsRepository(Ref ref) {
  final datasource = ref.watch(rentsFirestoreDatasourceProvider);
  return RentsRepositoryImpl(datasource);
}

class RentsRepositoryImpl implements RentsRepository {
  final RentsFirestoreDatasource _datasource;

  RentsRepositoryImpl(this._datasource);

  @override
  Future<void> createRent(Rent rent) async {
    try {
      final rentDto = rent.toDto();
      await _datasource.createRent(rentDto);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Rent>> getUserRents(String userEmail) async {
    try {
      final rentDtos = await _datasource.getUserRents(userEmail);
      return rentDtos.map((dto) => dto.toEntity()).toList();
    } catch (e) {
      rethrow;
    }
  }
}
