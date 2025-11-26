// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bikes_firestore_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bikesFirestoreDatasource)
const bikesFirestoreDatasourceProvider = BikesFirestoreDatasourceProvider._();

final class BikesFirestoreDatasourceProvider
    extends
        $FunctionalProvider<
          BikesFirestoreDatasource,
          BikesFirestoreDatasource,
          BikesFirestoreDatasource
        >
    with $Provider<BikesFirestoreDatasource> {
  const BikesFirestoreDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bikesFirestoreDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bikesFirestoreDatasourceHash();

  @$internal
  @override
  $ProviderElement<BikesFirestoreDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BikesFirestoreDatasource create(Ref ref) {
    return bikesFirestoreDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BikesFirestoreDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BikesFirestoreDatasource>(value),
    );
  }
}

String _$bikesFirestoreDatasourceHash() =>
    r'7044b101cf5c13f0aa5fb63b39bbc1f3bf230677';
