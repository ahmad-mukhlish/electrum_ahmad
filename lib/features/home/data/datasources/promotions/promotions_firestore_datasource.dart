import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/services/firebase/firebase_service.dart';
import '../../dtos/promotions/promotion_dto.dart';

part 'promotions_firestore_datasource.g.dart';

@riverpod
PromotionsFirestoreDatasource promotionsFirestoreDatasource(Ref ref) {
  final firestore = ref.watch(firestoreProvider);
  return PromotionsFirestoreDatasource(firestore);
}

class PromotionsFirestoreDatasource {
  final FirebaseFirestore _firestore;

  PromotionsFirestoreDatasource(this._firestore);

  /// Get promotions stream from Firestore
  Stream<List<PromotionDto>> getPromotions() {
    try {
      final snapshots = _firestore.collection('promotions').snapshots();
      return snapshots.map(
            (snapshot) => snapshot.docs
                .map((doc) => PromotionDto.fromJson(doc.data()))
                .toList(),
          );
    } catch (e) {
      rethrow;
    }
  }
}
