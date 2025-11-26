import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  final String? uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;

  UserDto({
    this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}

/// DTO to Entity mapper
extension UserDtoMapper on UserDto {
  /// Convert DTO to domain entity with default values
  User toEntity() => User(
        uid: uid ?? '',
        email: email ?? '',
        displayName: displayName,
        photoUrl: photoUrl,
      );
}
