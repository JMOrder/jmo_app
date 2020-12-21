import 'package:jmorder_app/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable(explicitToJson: true)
class Profile extends User {
  Profile(
      {int id, String email, String phone, String firstName, String lastName})
      : super(
            id: id,
            email: email,
            phone: phone,
            firstName: firstName,
            lastName: lastName);

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
