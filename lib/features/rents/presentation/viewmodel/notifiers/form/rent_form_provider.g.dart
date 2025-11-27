// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rent_form_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RentForm)
const rentFormProvider = RentFormProvider._();

final class RentFormProvider
    extends $NotifierProvider<RentForm, RentFormState> {
  const RentFormProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rentFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rentFormHash();

  @$internal
  @override
  RentForm create() => RentForm();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RentFormState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RentFormState>(value),
    );
  }
}

String _$rentFormHash() => r'b74cc2ab3e83cc5aedded3d8e1262f1a04c85c52';

abstract class _$RentForm extends $Notifier<RentFormState> {
  RentFormState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<RentFormState, RentFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RentFormState, RentFormState>,
              RentFormState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
