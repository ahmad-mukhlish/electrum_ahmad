// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plans_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(plansRepository)
const plansRepositoryProvider = PlansRepositoryProvider._();

final class PlansRepositoryProvider
    extends
        $FunctionalProvider<PlansRepository, PlansRepository, PlansRepository>
    with $Provider<PlansRepository> {
  const PlansRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'plansRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$plansRepositoryHash();

  @$internal
  @override
  $ProviderElement<PlansRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PlansRepository create(Ref ref) {
    return plansRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlansRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlansRepository>(value),
    );
  }
}

String _$plansRepositoryHash() => r'e19a973a088e4dbea4f1a1b4c368b5095ec2971f';
