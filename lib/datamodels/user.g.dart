// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as int,
    avatar: json['avatar'] as String,
    firstName: json['first_name'] as String,
    middleName: json['middle_name'] as String,
    lastName: json['last_name'] as String,
    fullName: json['full_name'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'avatar': instance.avatar,
      'first_name': instance.firstName,
      'middle_name': instance.middleName,
      'last_name': instance.lastName,
      'full_name': instance.fullName,
      'email': instance.email,
    };
