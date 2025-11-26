// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Stream provider for real-time promotions

@ProviderFor(promotions)
const promotionsProvider = PromotionsProvider._();

/// Stream provider for real-time promotions

final class PromotionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Promotion>>,
          List<Promotion>,
          Stream<List<Promotion>>
        >
    with $FutureModifier<List<Promotion>>, $StreamProvider<List<Promotion>> {
  /// Stream provider for real-time promotions
  const PromotionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'promotionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$promotionsHash();

  @$internal
  @override
  $StreamProviderElement<List<Promotion>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Promotion>> create(Ref ref) {
    return promotions(ref);
  }
}

String _$promotionsHash() => r'74204306ce0bca63c2ae5d36794c9a4d2f8e27e7';
