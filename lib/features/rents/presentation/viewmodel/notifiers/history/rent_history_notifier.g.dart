// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rent_history_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RentHistory)
const rentHistoryProvider = RentHistoryProvider._();

final class RentHistoryProvider
    extends $AsyncNotifierProvider<RentHistory, List<Rent>> {
  const RentHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rentHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rentHistoryHash();

  @$internal
  @override
  RentHistory create() => RentHistory();
}

String _$rentHistoryHash() => r'f507deb05f17729c8a1499baf93af10eaf563a97';

abstract class _$RentHistory extends $AsyncNotifier<List<Rent>> {
  FutureOr<List<Rent>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Rent>>, List<Rent>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Rent>>, List<Rent>>,
              AsyncValue<List<Rent>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
