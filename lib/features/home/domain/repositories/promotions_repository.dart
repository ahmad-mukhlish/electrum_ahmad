import '../entities/promotion/promotion.dart';

abstract class PromotionsRepository {
  Stream<List<Promotion>> getPromotions();
}
