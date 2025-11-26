// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bikes_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bikesRepository)
const bikesRepositoryProvider = BikesRepositoryProvider._();

final class BikesRepositoryProvider
    extends
        $FunctionalProvider<BikesRepository, BikesRepository, BikesRepository>
    with $Provider<BikesRepository> {
  const BikesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bikesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bikesRepositoryHash();

  @$internal
  @override
  $ProviderElement<BikesRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BikesRepository create(Ref ref) {
    return bikesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BikesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BikesRepository>(value),
    );
  }
}

String _$bikesRepositoryHash() => r'4a550c263252c09480a947f22ced70bb289a4dc4';
