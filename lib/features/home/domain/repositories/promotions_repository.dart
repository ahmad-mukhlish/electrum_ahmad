import '../entities/promotion.dart';

abstract class PromotionsRepository {
  Stream<List<Promotion>> getPromotions();
}
