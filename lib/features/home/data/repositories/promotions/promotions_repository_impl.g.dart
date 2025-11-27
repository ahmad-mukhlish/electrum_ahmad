// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotions_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(promotionsRepository)
const promotionsRepositoryProvider = PromotionsRepositoryProvider._();

final class PromotionsRepositoryProvider
    extends
        $FunctionalProvider<
          PromotionsRepository,
          PromotionsRepository,
          PromotionsRepository
        >
    with $Provider<PromotionsRepository> {
  const PromotionsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'promotionsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$promotionsRepositoryHash();

  @$internal
  @override
  $ProviderElement<PromotionsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PromotionsRepository create(Ref ref) {
    return promotionsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PromotionsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PromotionsRepository>(value),
    );
  }
}

String _$promotionsRepositoryHash() =>
    r'7710a4bac0df800744355c2b32afff8c81ba449a';
