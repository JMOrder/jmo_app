import 'package:flutter/material.dart';
import 'package:jmorder_app/models/connected_user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kakao_flutter_sdk/auth.dart';

part 'auth.g.dart';

@JsonSerializable()
class Auth {
  String token;
  String type;
  ConnectedUser connectedUser;
  String authDetail;
  AccessTokenResponse accessTokenResponse;

  Auth({
    @required this.token,
    @required this.type,
  });

  String get authorization => "$type $token";

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);
  Map<String, dynamic> toJson() => _$AuthToJson(this);
}
