import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(
  nullable: false,
  fieldRename: FieldRename.snake,
)
class User {
  final int id;
  final String avatar;
  String firstName;
  String middleName = "";
  String lastName;
  String fullName;
  String email;

  User({
    this.id,
    this.avatar,
    this.firstName,
    this.middleName,
    this.lastName,
    this.fullName,
    this.email,
  });
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
