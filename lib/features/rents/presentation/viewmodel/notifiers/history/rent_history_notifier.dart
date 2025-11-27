import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../auth/presentation/viewmodel/notifiers/auth_notifier.dart';
import '../../../../data/repositories/rents/rents_repository_impl.dart';
import '../../../../domain/entities/rent/rent.dart';

part 'rent_history_notifier.g.dart';

@riverpod
class RentHistory extends _$RentHistory {
  @override
  Future<List<Rent>> build() async {
    // Get current user from auth provider
    final user = await ref.watch(authProvider.future);

    if (user == null) {
      return [];
    }

    // Fetch user's rent history from repository
    final repository = ref.watch(rentsRepositoryProvider);
    return await repository.getUserRents(user.email);
  }
}
