import '../entities/bike.dart';

abstract class BikesRepository {
  Stream<List<Bike>> getBikes();
}
