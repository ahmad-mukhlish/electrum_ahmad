// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rents_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(rentsRepository)
const rentsRepositoryProvider = RentsRepositoryProvider._();

final class RentsRepositoryProvider
    extends
        $FunctionalProvider<RentsRepository, RentsRepository, RentsRepository>
    with $Provider<RentsRepository> {
  const RentsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rentsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rentsRepositoryHash();

  @$internal
  @override
  $ProviderElement<RentsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RentsRepository create(Ref ref) {
    return rentsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RentsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RentsRepository>(value),
    );
  }
}

String _$rentsRepositoryHash() => r'5424943b8163ddc21d61055fa6718cef59b95850';
