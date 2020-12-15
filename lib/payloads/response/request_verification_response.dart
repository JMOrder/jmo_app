import 'package:json_annotation/json_annotation.dart';

part 'request_verification_response.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class RequestVerificationResponse {
  String id;
  DateTime expiresAt;
  String timeunit;
  DateTime createdAt;

  RequestVerificationResponse({
    this.id,
    this.expiresAt,
    this.timeunit,
    this.createdAt,
  });

  factory RequestVerificationResponse.fromJson(Map<String, dynamic> json) =>
      _$RequestVerificationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RequestVerificationResponseToJson(this);
}
