import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(
  nullable: false,
  fieldRename: FieldRename.snake,
)
class User {
  final int id;
  final String avatar;
  final String username;
  final String role;
  final String firstName;
  final String middleName;
  final String lastName;
  final String fullName;
  final String email;
  final String timeZone;
  final String password;
  final String passwordConfirmation;

  User({
    @required this.id,
    this.avatar = "",
    this.username = "",
    this.role = "",
    this.firstName = "",
    this.middleName = "",
    this.lastName = "",
    this.fullName = "",
    this.email = "",
    this.timeZone = "",
    this.password = "",
    this.passwordConfirmation = "",
  });
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
