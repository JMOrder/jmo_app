import 'dart:core';

import 'package:jmorder_app/models/item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class OrderItem {
  int id;
  @JsonKey()
  Item item;
  double unitAmount;
  double quantity;
  String comment;

  OrderItem({
    this.id,
    this.item,
    this.unitAmount,
    this.quantity,
    this.comment,
  });

  String get summary =>
      "${unitAmount ?? ""}${item.unitName ?? ""} / $cleanQuantity${item.quantityName} ${comment != null ? '(' + comment + ')' : ''}";

  num get cleanQuantity => (quantity % 1 == 0 ? quantity.toInt() : quantity);

  bool hasUnit() {
    return item.unitName == null;
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}
