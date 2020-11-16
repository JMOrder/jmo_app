// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthDetail _$AuthDetailFromJson(Map<String, dynamic> json) {
  return AuthDetail(
    platform: json['platform'] as String,
    userId: json['userId'] as String,
    connectedAt: json['connectedAt'] == null
        ? null
        : DateTime.parse(json['connectedAt'] as String),
  );
}

Map<String, dynamic> _$AuthDetailToJson(AuthDetail instance) =>
    <String, dynamic>{
      'platform': instance.platform,
      'userId': instance.userId,
      'connectedAt': instance.connectedAt?.toIso8601String(),
    };
