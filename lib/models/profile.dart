import 'package:jmorder_app/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable(explicitToJson: true)
class Profile {
  int id;
  String email;
  String phone;
  String firstName;
  String lastName;

  String get fullName => "$lastName$firstName";

  Profile({this.id, this.email, this.phone, this.firstName, this.lastName});

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  User toUser() => User(
        id: id,
        email: email,
        phone: phone,
        firstName: firstName,
        lastName: lastName,
      );
}
