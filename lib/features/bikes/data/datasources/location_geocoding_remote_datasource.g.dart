// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_geocoding_remote_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(locationGeocodingRemoteDatasource)
const locationGeocodingRemoteDatasourceProvider =
    LocationGeocodingRemoteDatasourceProvider._();

final class LocationGeocodingRemoteDatasourceProvider
    extends
        $FunctionalProvider<
          LocationGeocodingRemoteDatasource,
          LocationGeocodingRemoteDatasource,
          LocationGeocodingRemoteDatasource
        >
    with $Provider<LocationGeocodingRemoteDatasource> {
  const LocationGeocodingRemoteDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationGeocodingRemoteDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$locationGeocodingRemoteDatasourceHash();

  @$internal
  @override
  $ProviderElement<LocationGeocodingRemoteDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocationGeocodingRemoteDatasource create(Ref ref) {
    return locationGeocodingRemoteDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocationGeocodingRemoteDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocationGeocodingRemoteDatasource>(
        value,
      ),
    );
  }
}

String _$locationGeocodingRemoteDatasourceHash() =>
    r'd0042880b9442a3009c5e661c4401b2da7fb6731';
