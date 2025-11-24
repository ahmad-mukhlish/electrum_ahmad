import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/repositories/auth_repository_impl.dart';

part 'auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<bool> build() async {
    final repo = ref.watch(authRepositoryProvider);
    return await repo.isLoggedIn();
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).login(email, password);
      return true;
    });
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = const AsyncData(false);
  }
}
