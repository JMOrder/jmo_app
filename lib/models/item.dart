import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Item extends Equatable {
  final int id;
  final String name;
  final String unitName;
  final String quantityName;
  final String comment;
  final bool favorite;

  Item({
    this.id,
    this.name,
    this.unitName,
    this.quantityName,
    this.comment,
    this.favorite,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);

  @override
  List<Object> get props => [id];
}
