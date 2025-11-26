// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plans_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider that transforms plans to UI states with discount calculations

@ProviderFor(plansState)
const plansStateProvider = PlansStateProvider._();

/// Provider that transforms plans to UI states with discount calculations

final class PlansStateProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PlanState>>,
          List<PlanState>,
          Stream<List<PlanState>>
        >
    with $FutureModifier<List<PlanState>>, $StreamProvider<List<PlanState>> {
  /// Provider that transforms plans to UI states with discount calculations
  const PlansStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'plansStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$plansStateHash();

  @$internal
  @override
  $StreamProviderElement<List<PlanState>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<PlanState>> create(Ref ref) {
    return plansState(ref);
  }
}

String _$plansStateHash() => r'3415453fce3bda1bbc41b572e1c17634e2702549';
