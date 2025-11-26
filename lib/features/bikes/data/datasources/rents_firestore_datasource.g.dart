// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rents_firestore_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(rentsFirestoreDatasource)
const rentsFirestoreDatasourceProvider = RentsFirestoreDatasourceProvider._();

final class RentsFirestoreDatasourceProvider
    extends
        $FunctionalProvider<
          RentsFirestoreDatasource,
          RentsFirestoreDatasource,
          RentsFirestoreDatasource
        >
    with $Provider<RentsFirestoreDatasource> {
  const RentsFirestoreDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rentsFirestoreDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rentsFirestoreDatasourceHash();

  @$internal
  @override
  $ProviderElement<RentsFirestoreDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RentsFirestoreDatasource create(Ref ref) {
    return rentsFirestoreDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RentsFirestoreDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RentsFirestoreDatasource>(value),
    );
  }
}

String _$rentsFirestoreDatasourceHash() =>
    r'8e69f1284c588bab6581709935e6990c6948319e';
