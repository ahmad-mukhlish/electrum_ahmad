import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/services/firebase/firebase_service.dart';
import '../../dtos/rents/rent_dto.dart';

part 'rents_firestore_datasource.g.dart';

@riverpod
RentsFirestoreDatasource rentsFirestoreDatasource(Ref ref) {
  final firestore = ref.watch(firestoreProvider);
  return RentsFirestoreDatasource(firestore);
}

class RentsFirestoreDatasource {
  final FirebaseFirestore _firestore;

  RentsFirestoreDatasource(this._firestore);

  /// Create a new rent document in Firestore
  Future<void> createRent(RentDto rentDto) async {
    try {
      final collection = _firestore.collection('rents');
      await collection.doc(rentDto.id).set(rentDto.toJson());
    } catch (e) {
      rethrow;
    }
  }

  /// Fetch rents for a specific user by contactEmail
  /// Query Firestore 'rents' collection filtered by user email
  /// Returns list ordered by createdAt descending (most recent first)
  Future<List<RentDto>> getUserRents(String userEmail) async {
    try {
      final collection = _firestore.collection('rents');
      final querySnapshot = await collection
          .where('contact-email', isEqualTo: userEmail)
          .orderBy('created-at', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => RentDto.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
