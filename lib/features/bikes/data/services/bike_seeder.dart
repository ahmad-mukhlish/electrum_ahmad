import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/firebase_service.dart';
import '../../domain/entities/bike.dart';
import '../seed_data/bike_seed_data.dart';

part 'bike_seeder.g.dart';

/// Provider for bike seeding operations
@riverpod
class BikeSeeder extends _$BikeSeeder {
  @override
  FutureOr<void> build() {
    // No initial state needed
  }

  /// Seed bikes to Firestore
  /// This will create/overwrite documents in the `bikes` collection
  Future<void> seedBikes() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final firestore = ref.read(firestoreProvider);
      await _seedBikesToFirestore(firestore);
    });
  }

  /// Internal method to perform the actual seeding
  Future<void> _seedBikesToFirestore(FirebaseFirestore firestore) async {
    try {
      final batch = firestore.batch();
      final col = firestore.collection('bikes');

      for (final bike in bikeSeedData) {
        final docRef = col.doc(bike.id);
        // Convert to DTO to get proper JSON field names
        final bikeDto = bike.toDto();
        batch.set(docRef, bikeDto.toJson());
      }

      await batch.commit();
    } catch (e) {
      rethrow;
    }
  }
}
