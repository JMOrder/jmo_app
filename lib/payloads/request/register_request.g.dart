// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) {
  return RegisterRequest(
    email: json['email'] as String,
    phone: json['phone'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'phone': instance.phone,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'password': instance.password,
    };
