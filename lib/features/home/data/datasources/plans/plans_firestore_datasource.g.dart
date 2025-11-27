// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plans_firestore_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(plansFirestoreDatasource)
const plansFirestoreDatasourceProvider = PlansFirestoreDatasourceProvider._();

final class PlansFirestoreDatasourceProvider
    extends
        $FunctionalProvider<
          PlansFirestoreDatasource,
          PlansFirestoreDatasource,
          PlansFirestoreDatasource
        >
    with $Provider<PlansFirestoreDatasource> {
  const PlansFirestoreDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'plansFirestoreDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$plansFirestoreDatasourceHash();

  @$internal
  @override
  $ProviderElement<PlansFirestoreDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PlansFirestoreDatasource create(Ref ref) {
    return plansFirestoreDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlansFirestoreDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlansFirestoreDatasource>(value),
    );
  }
}

String _$plansFirestoreDatasourceHash() =>
    r'538f17cd4646916073de19f40d0eafbf45ceee0e';
