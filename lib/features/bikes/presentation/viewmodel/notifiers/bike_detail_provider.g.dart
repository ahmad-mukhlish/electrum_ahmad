// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bike_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for fetching a single bike by ID
/// Returns Stream<Bike?> from Firestore for real-time updates

@ProviderFor(bikeDetail)
const bikeDetailProvider = BikeDetailFamily._();

/// Provider for fetching a single bike by ID
/// Returns Stream<Bike?> from Firestore for real-time updates

final class BikeDetailProvider
    extends $FunctionalProvider<AsyncValue<Bike?>, Bike?, Stream<Bike?>>
    with $FutureModifier<Bike?>, $StreamProvider<Bike?> {
  /// Provider for fetching a single bike by ID
  /// Returns Stream<Bike?> from Firestore for real-time updates
  const BikeDetailProvider._({
    required BikeDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'bikeDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bikeDetailHash();

  @override
  String toString() {
    return r'bikeDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Bike?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Bike?> create(Ref ref) {
    final argument = this.argument as String;
    return bikeDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is BikeDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bikeDetailHash() => r'196cec20bb3a0f1b1ba53f764be339c7dc192347';

/// Provider for fetching a single bike by ID
/// Returns Stream<Bike?> from Firestore for real-time updates

final class BikeDetailFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Bike?>, String> {
  const BikeDetailFamily._()
    : super(
        retry: null,
        name: r'bikeDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for fetching a single bike by ID
  /// Returns Stream<Bike?> from Firestore for real-time updates

  BikeDetailProvider call(String bikeId) =>
      BikeDetailProvider._(argument: bikeId, from: this);

  @override
  String toString() => r'bikeDetailProvider';
}
