// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_verification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestVerificationResponse _$RequestVerificationResponseFromJson(
    Map<String, dynamic> json) {
  return RequestVerificationResponse(
    id: json['id'] as String,
    expiresAt: json['expiresAt'] == null
        ? null
        : DateTime.parse(json['expiresAt'] as String),
    timeunit: json['timeunit'] as String,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
  );
}

Map<String, dynamic> _$RequestVerificationResponseToJson(
    RequestVerificationResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('expiresAt', instance.expiresAt?.toIso8601String());
  writeNotNull('timeunit', instance.timeunit);
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  return val;
}
