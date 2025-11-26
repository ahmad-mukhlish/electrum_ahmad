import '../entities/rent.dart';

abstract class RentsRepository {
  Future<void> createRent(Rent rent);
}
