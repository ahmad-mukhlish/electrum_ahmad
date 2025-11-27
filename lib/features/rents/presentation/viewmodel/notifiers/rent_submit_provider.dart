import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:electrum_ahmad/features/rents/data/repositories/rents/rents_repository_impl.dart';

import '../../../../bikes/domain/entities/bike.dart';
import '../../../domain/entities/rent/rent.dart';
import '../states/rent_form_state.dart';

part 'rent_submit_provider.g.dart';

@riverpod
class RentSubmit extends _$RentSubmit {
  @override
  FutureOr<void> build() {
    // No initial state needed
  }

  Future<void> submitRent(Bike bike, RentFormState formState) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(rentsRepositoryProvider);

      // Build Rent entity from form data
      final rent = Rent(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        bikeId: bike.id,
        fromDate: formState.fromDate!,
        toDate: formState.toDate!,
        pickupText: formState.pickupText,
        locationLat: formState.locationLat,
        locationLng: formState.locationLng,
        contactName: formState.contactName,
        contactPhone: formState.contactPhone,
        contactEmail: formState.contactEmail,
        totalDays: formState.totalDays,
        pricePerDay: bike.pricePerDay,
        totalAmount: formState.totalAmount(bike.pricePerDay),
        createdAt: DateTime.now(),
      );

      await repository.createRent(rent);
    });
  }
}
