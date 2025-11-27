// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rent_submit_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RentSubmit)
const rentSubmitProvider = RentSubmitProvider._();

final class RentSubmitProvider
    extends $AsyncNotifierProvider<RentSubmit, void> {
  const RentSubmitProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rentSubmitProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rentSubmitHash();

  @$internal
  @override
  RentSubmit create() => RentSubmit();
}

String _$rentSubmitHash() => r'8ea7068b18e6d10ca8142cd5c24b17ce70386bae';

abstract class _$RentSubmit extends $AsyncNotifier<void> {
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
