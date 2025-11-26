import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/dtos/user_dto.dart';

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

/// Entity to DTO mapper
extension UserMapper on User {
  /// Convert domain entity to DTO
  UserDto toDto() => UserDto(
        uid: uid,
        email: email,
        displayName: displayName,
        photoUrl: photoUrl,
      );
}
