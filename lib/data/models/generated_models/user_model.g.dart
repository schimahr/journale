// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    id: json['id'] as String,
    displayName: json['displayName'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'email': instance.email,
    };
