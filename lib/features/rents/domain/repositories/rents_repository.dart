import '../entities/rent/rent.dart';

abstract class RentsRepository {
  Future<void> createRent(Rent rent);
  Future<List<Rent>> getUserRents(String userEmail);
}
