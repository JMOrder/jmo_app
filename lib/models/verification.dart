import 'package:json_annotation/json_annotation.dart';

part 'verification.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Verification {
  String id;
  DateTime expiresAt;
  String timeunit;
  DateTime createdAt;

  Verification({
    this.id,
    this.expiresAt,
    this.timeunit,
    this.createdAt,
  });

  factory Verification.fromJson(Map<String, dynamic> json) =>
      _$VerificationFromJson(json);
  Map<String, dynamic> toJson() => _$VerificationToJson(this);
}
