import 'package:jmorder_app/models/item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'client.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Client {
  int id;
  String name;
  String phone;
  DateTime createdAt;
  DateTime updatedAt;
  @JsonKey(defaultValue: [])
  List<Item> items;

  Client({
    this.id,
    this.name,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.items,
  });

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);
  Map<String, dynamic> toJson() => _$ClientToJson(this);
}
