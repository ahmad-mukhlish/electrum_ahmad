// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bike_seeder.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for bike seeding operations

@ProviderFor(BikeSeeder)
const bikeSeederProvider = BikeSeederProvider._();

/// Provider for bike seeding operations
final class BikeSeederProvider
    extends $AsyncNotifierProvider<BikeSeeder, void> {
  /// Provider for bike seeding operations
  const BikeSeederProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bikeSeederProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bikeSeederHash();

  @$internal
  @override
  BikeSeeder create() => BikeSeeder();
}

String _$bikeSeederHash() => r'50a04b7e283804d166277496aa5becbc4755d823';

/// Provider for bike seeding operations

abstract class _$BikeSeeder extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
