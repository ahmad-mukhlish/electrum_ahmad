import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/firebase_service.dart';
import '../dtos/bike_dto.dart';

part 'bikes_firestore_datasource.g.dart';

@riverpod
BikesFirestoreDatasource bikesFirestoreDatasource(Ref ref) {
  final firestore = ref.watch(firestoreProvider);
  return BikesFirestoreDatasource(firestore);
}

class BikesFirestoreDatasource {
  final FirebaseFirestore _firestore;

  BikesFirestoreDatasource(this._firestore);

  /// Get bikes stream from Firestore ordered by model
  Stream<List<BikeDto>> getBikes() {
    try {
      final snapshots = _firestore
          .collection('bikes')
          .orderBy('model', descending: false)
          .snapshots();
      return snapshots.map(
        (snapshot) => snapshot.docs
            .map((doc) => BikeDto.fromJson(doc.data()))
            .toList(),
      );
    } catch (e) {
      rethrow;
    }
  }
}
