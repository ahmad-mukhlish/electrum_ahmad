import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/services/firebase/firebase_service.dart';
import '../../dtos/plans/plan_dto.dart';

part 'plans_firestore_datasource.g.dart';

@riverpod
PlansFirestoreDatasource plansFirestoreDatasource(Ref ref) {
  final firestore = ref.watch(firestoreProvider);
  return PlansFirestoreDatasource(firestore);
}

class PlansFirestoreDatasource {
  final FirebaseFirestore _firestore;

  PlansFirestoreDatasource(this._firestore);

  /// Get plans stream from Firestore ordered by id
  Stream<List<PlanDto>> getPlans() {
    try {
      final snapshots = _firestore
          .collection('plans')
          .orderBy('id', descending: false)
          .snapshots();
      return snapshots.map(
        (snapshot) => snapshot.docs
            .map((doc) => PlanDto.fromJson(doc.data()))
            .toList(),
      );
    } catch (e) {
      rethrow;
    }
  }
}
