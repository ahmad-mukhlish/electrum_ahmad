import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../auth/presentation/viewmodel/notifiers/auth_notifier.dart';
import '../states/rent_form_state.dart';

part 'rent_form_provider.g.dart';

@riverpod
class RentForm extends _$RentForm {
  @override
  RentFormState build() {
    // Load contact info from auth user and return initial state
    final authState = ref.read(authProvider);
    final user = authState.value;

    if (user != null) {
      return RentFormState(
        contactName: user.displayName ?? '',
        contactEmail: user.email,
      );
    }

    return const RentFormState();
  }

  void setFromDate(DateTime date) {
    state = state.copyWith(fromDate: date);
  }

  void setToDate(DateTime date) {
    state = state.copyWith(toDate: date);
  }

  void setPickupText(String text) {
    state = state.copyWith(pickupText: text);
  }

  void setLocation(double lat, double lng, String address) {
    state = state.copyWith(
      locationLat: lat,
      locationLng: lng,
      pickupText: address,
    );
  }

  void setContactPhone(String phone) {
    state = state.copyWith(contactPhone: phone);
  }


  void setContactName(String name) {
    state = state.copyWith(contactName: name);
  }


  void setContactEmail(String email) {
    state = state.copyWith(contactEmail: email);
  }

  void reset() {
    // Reset and reload contact info from auth user
    final authState = ref.read(authProvider);
    final user = authState.value;

    if (user != null) {
      state = RentFormState(
        contactName: user.displayName ?? '',
        contactEmail: user.email,
      );
    } else {
      state = const RentFormState();
    }
  }
}
