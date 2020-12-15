// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auth _$AuthFromJson(Map<String, dynamic> json) {
  return Auth(
    token: json['token'] as String,
    type: json['type'] as String,
  )
    ..connectedUser = json['connectedUser'] == null
        ? null
        : ConnectedUser.fromJson(json['connectedUser'] as Map<String, dynamic>)
    ..authDetail = json['authDetail'] as String;
}

Map<String, dynamic> _$AuthToJson(Auth instance) => <String, dynamic>{
      'token': instance.token,
      'type': instance.type,
      'connectedUser': instance.connectedUser,
      'authDetail': instance.authDetail,
    };
