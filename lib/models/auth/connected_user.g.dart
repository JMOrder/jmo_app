// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connected_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectedUser _$ConnectedUserFromJson(Map<String, dynamic> json) {
  return ConnectedUser(
    id: json['id'] as String,
    email: json['email'] as String,
    phone: json['phone'] as String,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    authorities: (json['authorities'] as List)
        ?.map((e) =>
            e == null ? null : Authority.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ConnectedUserToJson(ConnectedUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phone': instance.phone,
      'createdAt': instance.createdAt?.toIso8601String(),
      'authorities': instance.authorities?.map((e) => e?.toJson())?.toList(),
    };
