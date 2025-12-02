// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geolocator_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(geolocatorService)
const geolocatorServiceProvider = GeolocatorServiceProvider._();

final class GeolocatorServiceProvider
    extends
        $FunctionalProvider<
          GeolocatorService,
          GeolocatorService,
          GeolocatorService
        >
    with $Provider<GeolocatorService> {
  const GeolocatorServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'geolocatorServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$geolocatorServiceHash();

  @$internal
  @override
  $ProviderElement<GeolocatorService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GeolocatorService create(Ref ref) {
    return geolocatorService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GeolocatorService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GeolocatorService>(value),
    );
  }
}

String _$geolocatorServiceHash() => r'fb38a2367f5e62e241e02f9f8130e50ccd1d1e34';
