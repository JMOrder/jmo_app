import 'package:jmorder_app/models/auth/connected_user/authority.dart';
import 'package:json_annotation/json_annotation.dart';

part 'connected_user.g.dart';

@JsonSerializable(explicitToJson: true)
class ConnectedUser {
  String id;
  String email;
  String phone;
  DateTime createdAt;
  List<Authority> authorities;

  ConnectedUser({
    this.id,
    this.email,
    this.phone,
    this.createdAt,
    this.authorities,
  });

  factory ConnectedUser.fromJson(Map<String, dynamic> json) =>
      _$ConnectedUserFromJson(json);
  Map<String, dynamic> toJson() => _$ConnectedUserToJson(this);
}
