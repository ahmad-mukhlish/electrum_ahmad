// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bikes_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider that streams bikes from Firestore

@ProviderFor(bikes)
const bikesProvider = BikesProvider._();

/// Provider that streams bikes from Firestore

final class BikesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Bike>>,
          List<Bike>,
          Stream<List<Bike>>
        >
    with $FutureModifier<List<Bike>>, $StreamProvider<List<Bike>> {
  /// Provider that streams bikes from Firestore
  const BikesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bikesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bikesHash();

  @$internal
  @override
  $StreamProviderElement<List<Bike>> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<Bike>> create(Ref ref) {
    return bikes(ref);
  }
}

String _$bikesHash() => r'b119538b3b7a4811697ef5904648e0a6dd950d3e';
