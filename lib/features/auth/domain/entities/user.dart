import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  const User._();

  const factory User({
    required String uid,
    required String email,
    String? displayName,
    String? photoUrl,
  }) = _User;
}
