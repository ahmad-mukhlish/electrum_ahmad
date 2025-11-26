// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_period_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for managing the selected plan period

@ProviderFor(SelectedPeriod)
const selectedPeriodProvider = SelectedPeriodProvider._();

/// Provider for managing the selected plan period
final class SelectedPeriodProvider
    extends $NotifierProvider<SelectedPeriod, PlanPeriod> {
  /// Provider for managing the selected plan period
  const SelectedPeriodProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedPeriodProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedPeriodHash();

  @$internal
  @override
  SelectedPeriod create() => SelectedPeriod();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlanPeriod value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlanPeriod>(value),
    );
  }
}

String _$selectedPeriodHash() => r'98508224a1447a975e442c7d8ed5ccc202ef5c98';

/// Provider for managing the selected plan period

abstract class _$SelectedPeriod extends $Notifier<PlanPeriod> {
  PlanPeriod build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PlanPeriod, PlanPeriod>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PlanPeriod, PlanPeriod>,
              PlanPeriod,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
