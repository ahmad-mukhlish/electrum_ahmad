// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotions_firestore_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(promotionsFirestoreDatasource)
const promotionsFirestoreDatasourceProvider =
    PromotionsFirestoreDatasourceProvider._();

final class PromotionsFirestoreDatasourceProvider
    extends
        $FunctionalProvider<
          PromotionsFirestoreDatasource,
          PromotionsFirestoreDatasource,
          PromotionsFirestoreDatasource
        >
    with $Provider<PromotionsFirestoreDatasource> {
  const PromotionsFirestoreDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'promotionsFirestoreDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$promotionsFirestoreDatasourceHash();

  @$internal
  @override
  $ProviderElement<PromotionsFirestoreDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PromotionsFirestoreDatasource create(Ref ref) {
    return promotionsFirestoreDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PromotionsFirestoreDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PromotionsFirestoreDatasource>(
        value,
      ),
    );
  }
}

String _$promotionsFirestoreDatasourceHash() =>
    r'9159594a588c68ce2d6b984d5dbbaa6750099298';
