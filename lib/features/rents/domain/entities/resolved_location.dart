import 'package:freezed_annotation/freezed_annotation.dart';

part 'resolved_location.freezed.dart';

@freezed
abstract class ResolvedLocation with _$ResolvedLocation {
  const ResolvedLocation._();

  const factory ResolvedLocation({
    required double latitude,
    required double longitude,
    required String address,
  }) = _ResolvedLocation;
}
