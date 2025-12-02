// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geolocator_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(geolocatorDatasource)
const geolocatorDatasourceProvider = GeolocatorDatasourceProvider._();

final class GeolocatorDatasourceProvider
    extends
        $FunctionalProvider<
          GeolocatorDatasource,
          GeolocatorDatasource,
          GeolocatorDatasource
        >
    with $Provider<GeolocatorDatasource> {
  const GeolocatorDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'geolocatorDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$geolocatorDatasourceHash();

  @$internal
  @override
  $ProviderElement<GeolocatorDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GeolocatorDatasource create(Ref ref) {
    return geolocatorDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GeolocatorDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GeolocatorDatasource>(value),
    );
  }
}

String _$geolocatorDatasourceHash() =>
    r'08dfbe2c24a3b117d4e5702f57c678c6595de27c';
