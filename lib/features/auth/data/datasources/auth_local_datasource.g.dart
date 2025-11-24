// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_local_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authLocalDatasource)
const authLocalDatasourceProvider = AuthLocalDatasourceProvider._();

final class AuthLocalDatasourceProvider
    extends
        $FunctionalProvider<
          AuthLocalDatasource,
          AuthLocalDatasource,
          AuthLocalDatasource
        >
    with $Provider<AuthLocalDatasource> {
  const AuthLocalDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authLocalDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authLocalDatasourceHash();

  @$internal
  @override
  $ProviderElement<AuthLocalDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuthLocalDatasource create(Ref ref) {
    return authLocalDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthLocalDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthLocalDatasource>(value),
    );
  }
}

String _$authLocalDatasourceHash() =>
    r'd363b06a8d4e782e80613f6628412a2c719cb2ff';
