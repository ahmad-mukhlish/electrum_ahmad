// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_platform_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(locationPlatformService)
const locationPlatformServiceProvider = LocationPlatformServiceProvider._();

final class LocationPlatformServiceProvider
    extends
        $FunctionalProvider<
          LocationPlatformService,
          LocationPlatformService,
          LocationPlatformService
        >
    with $Provider<LocationPlatformService> {
  const LocationPlatformServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationPlatformServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationPlatformServiceHash();

  @$internal
  @override
  $ProviderElement<LocationPlatformService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocationPlatformService create(Ref ref) {
    return locationPlatformService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocationPlatformService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocationPlatformService>(value),
    );
  }
}

String _$locationPlatformServiceHash() =>
    r'050dddad36acb10f6541dfb113d077d414a04a81';
