import 'package:json_annotation/json_annotation.dart';

part 'auth_detail.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthDetail {
  String platform;
  String userId;
  DateTime connectedAt;

  AuthDetail({this.platform, this.userId, this.connectedAt});

  factory AuthDetail.fromJson(Map<String, dynamic> json) =>
      _$AuthDetailFromJson(json);
  Map<String, dynamic> toJson() => _$AuthDetailToJson(this);
}
