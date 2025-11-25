import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
abstract class UserDto with _$UserDto {
  const UserDto._();

  const factory UserDto({
    required String uid,
    required String email,
    String? displayName,
    String? photoUrl,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}

// Conversion extensions
extension UserDtoX on UserDto {
  /// Convert DTO to domain entity
  User toEntity() => User(
        uid: uid,
        email: email,
        displayName: displayName,
        photoUrl: photoUrl,
      );
}

extension UserX on User {
  /// Convert domain entity to DTO
  UserDto toDto() => UserDto(
        uid: uid,
        email: email,
        displayName: displayName,
        photoUrl: photoUrl,
      );
}
