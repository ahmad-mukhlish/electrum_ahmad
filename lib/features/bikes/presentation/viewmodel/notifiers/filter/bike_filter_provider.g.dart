// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bike_filter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BikeFilter)
const bikeFilterProvider = BikeFilterProvider._();

final class BikeFilterProvider
    extends $NotifierProvider<BikeFilter, BikeFilterState> {
  const BikeFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bikeFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bikeFilterHash();

  @$internal
  @override
  BikeFilter create() => BikeFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BikeFilterState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BikeFilterState>(value),
    );
  }
}

String _$bikeFilterHash() => r'035c6e5e7b7a76696b37abbd99ae167d62f012ab';

abstract class _$BikeFilter extends $Notifier<BikeFilterState> {
  BikeFilterState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<BikeFilterState, BikeFilterState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BikeFilterState, BikeFilterState>,
              BikeFilterState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
