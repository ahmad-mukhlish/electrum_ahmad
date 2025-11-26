import '../entities/bike.dart';

abstract class BikesRepository {
  Stream<List<Bike>> getBikes();
  Stream<Bike?> getBikeById(String bikeId);
}
