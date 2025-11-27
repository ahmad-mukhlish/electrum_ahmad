import '../entities/rent/rent.dart';

abstract class RentsRepository {
  Future<void> createRent(Rent rent);
}
