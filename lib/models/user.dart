import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  int id;
  String email;
  String phone;
  String firstName;
  String lastName;

  String get fullName => "$lastName$firstName";

  User({this.id, this.email, this.phone, this.firstName, this.lastName});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
