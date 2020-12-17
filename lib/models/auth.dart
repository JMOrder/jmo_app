import 'package:flutter/material.dart';
import 'package:jmorder_app/models/auth/connected_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

@JsonSerializable()
class Auth {
  String token;
  String type;
  ConnectedUser connectedUser;
  String authDetail;

  Auth({
    @required this.token,
    @required this.type,
  });

  String get authorization => "$type $token";

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);
  Map<String, dynamic> toJson() => _$AuthToJson(this);
}
