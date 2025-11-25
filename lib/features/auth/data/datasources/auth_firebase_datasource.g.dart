// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_firebase_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authFirebaseDatasource)
const authFirebaseDatasourceProvider = AuthFirebaseDatasourceProvider._();

final class AuthFirebaseDatasourceProvider
    extends
        $FunctionalProvider<
          AuthFirebaseDatasource,
          AuthFirebaseDatasource,
          AuthFirebaseDatasource
        >
    with $Provider<AuthFirebaseDatasource> {
  const AuthFirebaseDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authFirebaseDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authFirebaseDatasourceHash();

  @$internal
  @override
  $ProviderElement<AuthFirebaseDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuthFirebaseDatasource create(Ref ref) {
    return authFirebaseDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthFirebaseDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthFirebaseDatasource>(value),
    );
  }
}

String _$authFirebaseDatasourceHash() =>
    r'0edbb579bef3ef3c95cebca3a92db6dc5e47ed50';
