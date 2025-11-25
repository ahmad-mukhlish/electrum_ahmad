// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_db_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sharedPreferences)
const sharedPreferencesProvider = SharedPreferencesProvider._();

final class SharedPreferencesProvider
    extends
        $FunctionalProvider<
          AsyncValue<SharedPreferences>,
          SharedPreferences,
          FutureOr<SharedPreferences>
        >
    with
        $FutureModifier<SharedPreferences>,
        $FutureProvider<SharedPreferences> {
  const SharedPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferencesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesHash();

  @$internal
  @override
  $FutureProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SharedPreferences> create(Ref ref) {
    return sharedPreferences(ref);
  }
}

String _$sharedPreferencesHash() => r'dc403fbb1d968c7d5ab4ae1721a29ffe173701c7';

@ProviderFor(localDbService)
const localDbServiceProvider = LocalDbServiceProvider._();

final class LocalDbServiceProvider
    extends $FunctionalProvider<LocalDbService, LocalDbService, LocalDbService>
    with $Provider<LocalDbService> {
  const LocalDbServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localDbServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localDbServiceHash();

  @$internal
  @override
  $ProviderElement<LocalDbService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LocalDbService create(Ref ref) {
    return localDbService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalDbService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalDbService>(value),
    );
  }
}

String _$localDbServiceHash() => r'c97df80f7cbb835caa8ae1b9bc20193ac9a068f5';
