// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_remote_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(locationRemoteDatasource)
const locationRemoteDatasourceProvider = LocationRemoteDatasourceProvider._();

final class LocationRemoteDatasourceProvider
    extends
        $FunctionalProvider<
          LocationRemoteDatasource,
          LocationRemoteDatasource,
          LocationRemoteDatasource
        >
    with $Provider<LocationRemoteDatasource> {
  const LocationRemoteDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationRemoteDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationRemoteDatasourceHash();

  @$internal
  @override
  $ProviderElement<LocationRemoteDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocationRemoteDatasource create(Ref ref) {
    return locationRemoteDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocationRemoteDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocationRemoteDatasource>(value),
    );
  }
}

String _$locationRemoteDatasourceHash() =>
    r'3d0415012bd922cc31b1043df1e56adf50ea5c25';
